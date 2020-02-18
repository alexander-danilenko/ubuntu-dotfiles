#!/usr/bin/env bash

set -e

################## Variables ###################################################

# List of drivers to install.
DRIVERS=(
  'rtl8812au-5.6.4.2-master'
  'rtl8822bu-master'
)
CURRENT_DIR=$(pwd)

################## Helper functions ############################################

echo_red() {
    echo  "$(tput setaf 1)$1$(tput sgr0)"
}
echo_green() {
    echo  "$(tput setaf 2)$1$(tput sgr0)"
}
echo_yellow() {
    echo  "$(tput setaf 3)$1$(tput sgr0)"
}

################## Process #####################################################

for drivername in ${DRIVERS[@]}
do
    if [ ! -f $CURRENT_DIR/drivers/$drivername.zip ]; then
        echo_red "./drivers/$drivername.zip does not exist. Aborting."
        exit 1
    fi

    echo_yellow "[$drivername] Unzipping driver to /usr/src/$drivername ..."
    sudo rm -rf /usr/src/$drivername
    sudo unzip ${CURRENT_DIR}/drivers/$drivername.zip -d /usr/src/ > /dev/null

    echo_yellow "[$drivername] Running 'make && make install'"
    cd /usr/src/$drivername && \
    sudo make > /dev/null && \
    sudo make install
done

echo_green "Drivers installation completed."
