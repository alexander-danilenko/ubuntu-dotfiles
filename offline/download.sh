#!/usr/bin/env bash

set -e

################## Variables ###################################################

# Linux kernel version. Current version by default.
KERNEL=${KERNEL:-$(uname -r)}
# List of packages required for download.
PACKAGES=(
    linux-image-${KERNEL}
    linux-modules-${KERNEL}
    linux-modules-extra-${KERNEL}
    linux-headers-${KERNEL}
    build-essential # C/C++ building tools.
    exfat-fuse      # exFAT file system drivers.
    exfat-utils     # exFAT file system tools.
    net-tools       # Basic networking tools handy for setup.
)
declare -A DRIVERS=(
  ['rtl8812au-5.6.4.2-master']='https://codeload.github.com/gordboy/rtl8812au-5.6.4.2/zip/master'
  ['rtl8822bu-master']='https://codeload.github.com/EntropicEffect/rtl8822bu/zip/master'
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
echo_yellow() {
    echo  "$(tput setaf 3)$1$(tput sgr0)"
}

################## Process #####################################################

CURRENT_DIR=$(pwd)

# Make sure all dependencies satisfied.
for i in "${DEPENDENCIES[@]}"; do
    echo_green "Making sure $i package is installed"
    which $i 2>/dev/null || { sudo apt-get install -y -q $i; }
done

mkdir -p $CURRENT_DIR/deb $CURRENT_DIR/drivers

echo_yellow "Downloading drivers..."
cd $CURRENT_DIR/drivers && \
for drivername in ${!DRIVERS[@]}
do
  echo_yellow "[$drivername] Downloading..."
  curl --silent -L ${DRIVERS[$drivername]} -o $CURRENT_DIR/drivers/$drivername.zip
done

echo_yellow "Downloading all packages with their dependencies..."
cd $CURRENT_DIR/deb
apt-get download -q $(apt-rdepends ${PACKAGES[*]} | grep -v "^ " | \
    # Exclude packages that has no installable packages.
    grep -v "^kldutils$" | \
    grep -v "^libc-dev$"| \
    grep -v "^debconf-2.0$") && \

echo_green "Done."
exit 0
