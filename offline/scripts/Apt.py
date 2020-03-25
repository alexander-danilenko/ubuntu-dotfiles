from .Logger import *
import os
import subprocess
import apt


# Downloads deb files for list of packages with all their dependencies.
class AptDownload:
    # Directory to download deb files to.
    download_dir: str
    # Kernel version. Should be 'uname -r' compatible value.
    kernel: str
    # List of packages that needs to be downloaded.
    packages: [str]
    # The logger.
    logger: Logger

    def __init__(self, packages, kernel='current', download_dir='./deb'):
        self.logger = Logger('apt')
        self.download_dir = os.path.abspath(download_dir)
        self.set_kernel(kernel)
        self.set_packages(packages)

    # Sets kernel version.
    def set_kernel(self, kernel):
        self.kernel = kernel
        if self.kernel.lower() == 'current':
            k = subprocess.Popen('uname -r', stdout=subprocess.PIPE, shell=True)
            self.kernel = k.stdout.read().decode('utf-8').replace('\n', '')
        self.logger.log(f'Using kernel "{self.kernel}"')
        return self

    # Sets packages list.
    def set_packages(self, packages):
        self.packages = packages
        for i in range(len(packages)):
            # Replace '{KERNEL}' with real kernel version.
            self.packages[i] = self.packages[i].replace('{KERNEL}', self.kernel)
        return self

    def get_download_list(self):
        return self.packages + AptDependencies(self.packages).get_dependencies()

    def download(self):
        # Create download directory if not exists
        if not os.path.exists(self.download_dir):
            os.makedirs(self.download_dir)
        # Navigate to download directory
        os.chdir(self.download_dir)
        # Run 'apt download' in terminal.
        subprocess.run('apt-get download ' + ' '.join(self.get_download_list()), shell=True)
        self.logger.log(f'All packages was downloaded to "{self.download_dir}"')


# Calculates dependencies recursively for apt package list.
# @see https://gitlab.com/michaelgugino/apt-deps/-/blob/master/apt_deps/get_deps.py
class AptDependencies:

    def __init__(self, packages, recommends=False):
        self.dependencies = set()
        self.apt_cache = apt.cache.Cache()
        self.apt_cache.open()
        for item in packages:
            package_cache = self.apt_cache[item]
            self.calculate_dependencies(self.dependencies, package_cache, recommends)
        self.apt_cache.close()

    # Recursively calculates dependency tree.
    def calculate_dependencies(self, s, package_cache, recommends=False):
        depends = package_cache.candidate.get_dependencies('Depends')
        pre_depends = package_cache.candidate.get_dependencies('PreDepends')
        all_dependencies = depends + pre_depends
        if recommends:
            all_dependencies.extend(package_cache.candidate.get_dependencies('Recommends'))
        for i in all_dependencies:
            dp = i.installed_target_versions
            if len(dp) > 0:
                if not dp[0].package.name in s:
                    s.add(dp[0].package.name)
                    self.calculate_dependencies(s, dp[0].package, recommends)

    def get_dependencies(self):
        return list(self.dependencies)