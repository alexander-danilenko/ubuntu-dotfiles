This directory contains helper scripts specific for my PC offline setup for making WiFi dongles and xBox gamepad great again.

## Usage

#### Source machine
1. **Clone** repo on a system with active network connection (source machine).
2. **Run** `./download` for start `*.deb` packages and drivers downloading. Files will be downloaded to `deb` and `drivers` directories accordingly.

#### Target machine
3. **Copy** repo with downloaded files to machine without network connection (target machine).
4. **Run** `./install-deb` for installation of downloaded deb packages. It will install everything you need for drivers compilation and installation.
5. **Run** `./install-drivers` for drivers installation.

## Contents

Below is a list of drivers that is going to be downloaded with `download` script:

|    Chip   |                Driver sources                | Kernel |
|:----------|:---------------------------------------------|:------:|
| RTL8812AU | https://github.com/gordboy/rtl8812au-5.6.4.2 | 5.4    |
| RTL8822BU | https://github.com/EntropicEffect/rtl8822bu  | 5.4    |
| xpadneo   | https://github.com/atar-axis/xpadneo         | 5.4    |

See [config.yml](config.yml) for the details.
