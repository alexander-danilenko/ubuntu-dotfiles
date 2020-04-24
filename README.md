## TL;DR

This repo contains Ansible scripts for fast and easy PHP/Drupal developer linux setup and dotfiles for Kubuntu. 

---

## Motivation
Setting up a new PHP/Drupal developer machine can be an ad-hoc, manual, and time-consuming process. Current project aims to simplify the process with instructions and dotfiles/scripts to automate the setup of the following:

- ZSH + [antigen](https://github.com/zsh-users/antigen) + [beast config](home/.zshrc)
- [PHP](https://www.php.net/)
- [Composer](https://getcomposer.org/)
- [Drupal CodeSniffer standard](https://git.drupalcode.org/project/coder/tree/8.x-3.x/coder_sniffer)
- [Node](https://nodejs.org/en/)/[NPM](https://www.npmjs.com/) (via [NVM (node version manager)](https://github.com/nvm-sh/nvm))
- [JetBrains IDEs](https://www.jetbrains.com/):
  - [PHPStorm](https://snapcraft.io/phpstorm)
  - [PyCharm (CE)](https://snapcraft.io/pycharm-community)
  - [IDEA (CE)](https://snapcraft.io/intellij-idea-community)
- [Docker](https://www.docker.com/)
- [Docksal](https://docksal.io/)
- [Visual Studio Code](https://code.visualstudio.com/) + Plugins + Themes
- [Sublime Text](https://www.sublimetext.com/)
- [Sublime Merge](https://www.sublimemerge.com/)
- [Google Chrome](https://www.google.com/chrome/)
- [Slack Chat](https://snapcraft.io/slack)
- [Skype](https://snapcraft.io/skype)
- [Zoom](https://snapcraft.io/zoom-client)
- ...and many many more (see [`config.yml`](config.yml) file).

## Tested on following distributions:
- [ubuntu 20.04](https://ubuntu.com/)
- [kubuntu 20.04](https://kubuntu.org/)

## Usage

1. Clone repo.
2. Open [`config.yml`](config.yml) and adjust for your needs.
3. Run `./install.sh` for running system provisor.
