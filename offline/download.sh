#!/usr/bin/env bash

set -e

KERNEL=${KERNEL:-5.3.0-26}
PACKAGES=(
    linux-image-${KERNEL}-generic
    linux-modules-${KERNEL}-generic
    linux-modules-extra-${KERNEL}-generic
    linux-headers-${KERNEL}-generic
    build-essential
    exfat-utils
    net-tools
)

echo_green() {
    echo  "$(tput setaf 2)$1$(tput sgr0)"
}

echo_green "Install apt-rdepends package if not installed."
which apt-rdepends 2>/dev/null || { sudo apt-get install -y -q apt-rdepends; }

echo_green "Install git package if not installed."
which git 2>/dev/null || { sudo apt-get install -y -q git; }

mkdir -p ./deb ./drivers

echo_green "Downloading drivers.."
[[ ! -d "$CURRENT_DIR/drivers/RTL8812AU" ]] && git clone https://github.com/gordboy/rtl8812au-5.6.4.2.git drivers/RTL8812AU
[[ ! -d "$CURRENT_DIR/drivers/RTL8822BU" ]] && git clone https://github.com/EntropicEffect/rtl8822bu.git drivers/RTL8822BU

echo_green "Downloading all packages with their dependencies..."

cd ./deb
apt-get download -q $(apt-rdepends ${PACKAGES[*]} | grep -v "^ " | \
    # Exclude packages that has no installable packages.
    grep -v "^kldutils$" | \
    grep -v "^libc-dev$"| \
    grep -v "^debconf-2.0$") && \

echo_green "Done."
exit 0
