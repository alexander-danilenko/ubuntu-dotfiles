from .Logger import *
import os
import requests
import sys
import tempfile
import zipfile
import subprocess
import shutil


# Driver handler. Downloads and installs driver.
class Driver:
    # URL of zip file to download driver from.
    download_url: str

    # Directory to download driver to.
    download_dir: str

    # Filaname for archive file in download_dir path.
    filename: str

    # Full (absolute) path to archive file.
    download_file_path: str

    # List of commands that should be executed inside downloaded driver's
    # source directory.
    install_commands: [str]

    # Response object.
    response: requests.Response

    # Logger.
    logger: Logger

    def __init__(self, url, filename, install_commands, download_dir='./drivers'):
        self.logger = Logger(f'driver|{filename}')
        self.download_url = url
        self.filename = filename
        self.download_dir = os.path.abspath(download_dir)
        self.download_file_path = os.path.normpath(f"{self.download_dir}/{self.filename}")
        self.install_commands = install_commands

    # Downloads driver to directory with certain filename.
    def download(self):
        if os.path.exists(self.download_file_path):
            self.logger.info('File exists, skipping...')
            return
        self.logger.log('Downloading...')

        # Make sure drivers directory created.
        if not os.path.exists(self.download_dir):
            os.makedirs(self.download_dir)

        # Make request.
        try:
            self.response = requests.get(self.download_url)
        except requests.exceptions.RequestException as e:  # This is the correct syntax
            self.logger.error('ERROR: Something went wrong. See details below.')
            self.logger.error(e)
            sys.exit(1)

        if self.response.status_code != 200:
            self.logger.error(f'ERROR: Retrieved response with non 200 code for url: {self.download_url}')
            self.logger.warning('Make sure that URL is correct.')
            sys.exit(1)

        # Write downloaded binary file to archive file.
        open(self.download_file_path, 'wb').write(self.response.content)

        return self

    # Unpacks downloaded driver and runs install commands on unarchived sources
    # directory.
    def install(self):
        if not os.path.exists(self.download_file_path):
            self.logger.error(f'ERROR: Driver was not found at {self.download_file_path}')
            sys.exit(1)

        # Create tmp directory before unzipping.
        tmp_dir = tempfile.mkdtemp(f'-{self.filename}-driver')

        # Unzip file.
        self.logger.log(f'Unpacking driver to: {tmp_dir}')
        with zipfile.ZipFile(self.download_file_path, 'r') as zip_ref:
            zip_ref.extractall(tmp_dir)

        # Convert commands to a string concatenated with ' && '.
        command_line = f'cd {tmp_dir} && {" && ".join(self.install_commands)}'
        self.logger.log(f'Executing install command: "{command_line}"')
        subprocess.run(command_line, shell=True)

        # Remove driver tmp directory.
        self.logger.log(f'Removing {tmp_dir}')
        shutil.rmtree(tmp_dir)
        self.logger.log('Driver was successfully installed.')

        return self
