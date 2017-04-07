#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="/opt/twitter/bin:/opt/twitter/sbin:/usr/local/mysql/bin:${HOME}/bin:$PATH:$HOME/.rvm/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Custom movement
bindkey "^B" backward-word
bindkey "^F" forward-word

if [[ -s "${ZDORDIR:-$HOME}/.zshrc.local" ]]; then
  source "${ZDORDIR:-$HOME}/.zshrc.local"
fi
