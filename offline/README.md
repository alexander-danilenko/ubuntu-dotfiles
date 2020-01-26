This directory contains helper scripts specific for my PC offline setup for making WiFi dongles great again.

- `download.sh` - Downloads drivers and all `*.deb` packages required for system install.
- `install.sh` - Installs all `*.deb` downloaded packages.

Below is a list of drivers that is going to be downloaded with `download.sh` script:

|    Chip   |                Driver sources                | Kernel |
|:---------:|:--------------------------------------------:|:------:|
| RTL8812AU | https://github.com/gordboy/rtl8812au-5.6.4.2 | 5.3    |
| RTL8822BU | https://github.com/EntropicEffect/rtl8822bu  | 5.3    |