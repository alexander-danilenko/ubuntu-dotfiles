# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi

PATH_DIRS=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/.composer/vendor/bin"
)
for PATH_DIR in ${PATH_DIRS[@]}; do
  if [ -d "$PATH_DIR" ]; then
    PATH="$PATH_DIR:$PATH"
  fi
done

# Fix Flatpak missing main menu icons.
if [ -d "/var/lib/flatpak/exports/share/applications" ]; then 
  XDG_DATA_DIRS="$XDG_DATA_DIRS:/var/lib/flatpak/exports/share/applications"
fi

# Configure NVM.
export NVM_DIR="${HOME}/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ] ; then
  source "$NVM_DIR/nvm.sh"
  # If npm installed.
  if [ -x "$(command -v npm)" ]; then
    # Add global npm binaries to path.
    PATH="$PATH:$(npm config --global get prefix)/bin"
  fi
fi
