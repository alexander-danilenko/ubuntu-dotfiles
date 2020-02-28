class Logger:
    # Logger channel.
    channel: str

    def __init__(self, channel: str):
        self.channel = channel

    def log(self, message):
        print(f'\033[92m[{self.channel}] {message}\033[0m')

    def info(self, message):
        print(f'\033[94m[{self.channel}] {message}\033[0m')

    def warning(self, message):
        print(f'\033[93m[{self.channel}] {message}\033[0m')

    def error(self, message):
        print(f'\033[91m[{self.channel}] {message}\033[0m')
