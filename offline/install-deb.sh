#!/usr/bin/env bash

set -e

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

if [ "$(ls -A ./deb | grep ".deb$")" ]; then
  echo_yellow "./deb directory has deb files. Installing them..."
  sudo dpkg -i ./deb/*.deb && sudo apt-get install --fix-broken
else
  echo_red "ERROR: './deb' directory has no deb files."
  exit 1
fi

echo_green "Deb files installation was completed."