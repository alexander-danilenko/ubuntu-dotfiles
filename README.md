## TL;DR

This repo contains Ansible scripts for fast and easy PHP/Drupal developer linux setup and dotfiles for Kubuntu. 

---

## Motivation
Setting up a new PHP/Drupal developer machine can be an ad-hoc, manual, and time-consuming process. Current project aims to simplify the process with instructions and dotfiles/scripts to automate the setup of the following:

- [PHP](https://www.php.net/)
- [Composer](https://getcomposer.org/)
- [Drupal CodeSniffer standard](https://git.drupalcode.org/project/coder/tree/8.x-3.x/coder_sniffer)
- Node/NPM (via [NVM](https://github.com/nvm-sh/nvm)) installation
- [JetBrains Toolbox](https://www.jetbrains.com/toolbox-app/)
- ZSH + Plugins
- [Docker](https://www.docker.com/)
- [Docksal](https://docksal.io/)
- [Visual Studio Code](https://code.visualstudio.com/) + Plugins + Themes
- [Sublime Text](https://www.sublimetext.com/)
- [Sublime Merge](https://www.sublimemerge.com/)
- Google Chrome
- Slack Chat
- Skype
- Zoom
- ...and many many more (see [`config.yml`](config.yml) file).

## Tested on following distributions:
- [Kubuntu 18.04](https://kubuntu.org/)
- [KDE Neon](https://neon.kde.org/)
- [Linux Mint 19.3](https://www.linuxmint.com/edition.php?id=274)

## Usage

1. Clone repo.
2. Open `config.yml` and adjust for your needs.
3. Run `./install.sh` for running system provisor.
