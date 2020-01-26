#!/usr/bin/env bash

set -e

################## Variables ###################################################

# List of packages required for script to run.
DEPENDENCIES=(
    ansible
    git
)

################## Helper functions ############################################
echo_green() {
    echo  "$(tput setaf 2)$1$(tput sgr0)"
}

################## Process #####################################################

# Make sure all dependencies satisfied.
for i in "${DEPENDENCIES[@]}"; do
    echo_green "$(tput setaf 2)Making sure $i package is installed$(tput sgr0)"
    which $i 2>/dev/null || { sudo apt-get install -y -q $i; }
done

echo_green "Satisfying ansible dependencies..."
ansible-galaxy install -r ansible/roles/requirements.yml --roles-path ./ansible/roles && \

echo_green "Running ansible playbook..."
ansible-playbook ansible/_post-system-install.yml --ask-become-pass