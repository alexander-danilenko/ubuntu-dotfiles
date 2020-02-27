class Rainbow:
    header    = '\033[95m'
    blue      = '\033[94m'
    green     = '\033[92m'
    warning   = '\033[93m'
    fail      = '\033[91m'
    end       = '\033[0m'
    bold      = '\033[1m'
    underline = '\033[4m'

def print_header(text):
    print(f"{Rainbow.header}{text}{Rainbow.end}")


def print_blue(text):
    print(f"{Rainbow.blue}{text}{Rainbow.end}")


def print_green(text):
    print(f"{Rainbow.green}{text}{Rainbow.end}")


def print_warning(text):
    print(f"{Rainbow.warning}{text}{Rainbow.end}")


def print_fail(text):
    print(f"{Rainbow.fail}{text}{Rainbow.end}")


def print_bold(text):
    print(f"{Rainbow.bold}{text}{Rainbow.end}")


def print_underline(text):
    print(f"{Rainbow.underline}{text}{Rainbow.end}")
