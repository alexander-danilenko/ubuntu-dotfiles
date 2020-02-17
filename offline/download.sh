#!/usr/bin/env bash

set -e

################## Variables ###################################################
# Linux kernel version that drivers was tested on.
KERNEL=${KERNEL:-5.3.0-28}
# List of packages required for download.
PACKAGES=(
    linux-image-${KERNEL}-generic
    linux-modules-${KERNEL}-generic
    linux-modules-extra-${KERNEL}-generic
    linux-headers-${KERNEL}-generic
    build-essential # C/C++ building tools.
    exfat-fuse      # exFAT file system drivers.
    exfat-utils     # exFAT file system tools.
    net-tools       # Basic networking tools handy for setup.
)

# List of packages required for script to run.
DEPENDENCIES=(
    curl
    apt-rdepends
)

################## Helper functions ############################################
echo_green() {
    echo  "$(tput setaf 2)$1$(tput sgr0)"
}

################## Process #####################################################

# Make sure all dependencies satisfied.
for i in "${DEPENDENCIES[@]}"; do
    echo_green "Making sure $i package is installed"
    which $i 2>/dev/null || { sudo apt-get install -y -q $i; }
done

mkdir -p ./deb ./drivers

echo_green "Downloading drivers.."
curl --silent https://codeload.github.com/gordboy/rtl8812au-5.6.4.2/zip/master -o drivers/RTL8812AU.zip
curl --silent https://codeload.github.com/EntropicEffect/rtl8822bu/zip/master  -o drivers/RTL8822BU.zip

echo_green "Downloading all packages with their dependencies..."
cd ./deb
apt-get download -q $(apt-rdepends ${PACKAGES[*]} | grep -v "^ " | \
    # Exclude packages that has no installable packages.
    grep -v "^kldutils$" | \
    grep -v "^libc-dev$"| \
    grep -v "^debconf-2.0$") && \

echo_green "Done."
exit 0
