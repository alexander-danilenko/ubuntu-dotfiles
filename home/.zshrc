export NVM_LAZY_LOAD=true

source ~/.antigen/antigen.zsh
source ~/.profile

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

antigen bundle git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle lukechilds/zsh-nvm

# Load the theme.
antigen theme gentoo

# Tell Antigen that you're done.
antigen apply
