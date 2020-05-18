#!/usr/bin/env bash

set -e

################## Variables ###################################################

# Packages required for script to run.
which git 2>/dev/null || { sudo apt-get install -y -q git >/dev/null; }
which ansible 2>/dev/null || { sudo apt-get install -y -q ansible >/dev/null ; }

################## Helper functions ############################################
echo_green() {
    echo  "$(tput setaf 2)$1$(tput sgr0)"
}

################## Process #####################################################

echo_green "Satisfying ansible dependencies..."
ansible-galaxy install -r ansible/roles/requirements.yml --roles-path ./ansible/roles && \

echo_green "Running ansible playbook..."
ansible-playbook ansible/main.yml --ask-become-pass
