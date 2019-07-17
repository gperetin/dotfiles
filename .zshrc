# Created by newuser for 5.6.2

autoload -Uz compinit promptinit
compinit
promptinit

autoload -Uz vcs_info
precmd() { vcs_info }

# Format the VCS branch info
zstyle ':vcs_info:git:*' formats ' %b'
zstyle ':vcs_info:*' enable git

# General config
setopt no_beep

# Completion settings
# ===================
# This makes it so that <TAB> iterates over options
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ''
# case-insensitive, partial-word, and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'


# Functions
git-prompt-info() {
  git rev-parse --is-inside-work-tree &>/dev/null || return
  # It would be nice to have the dirty indicator in the prompt, but it's just too slow for
  # larger repos, so I'm not using that
  # echo " %f${vcs_info_msg_0_}$(git-dirty)%f"
  echo " %f${vcs_info_msg_0_}%f"
}

git-dirty() {
  test -z "$(command git status --porcelain --ignore-submodules -unormal)"
  if [[ $? -eq 1 ]]; then
    echo ' %F{red}✗%f'
  else
    echo ' %F{green}✔%f'
  fi
}

# Prompt
# NerdFonts have to be installed for this prompt to work https://nerdfonts.com/
setopt PROMPT_SUBST
PROMPT='%F{magenta}%1~$(git-prompt-info)%f ❯ '

# More history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

# Remove until '/' when using Ctrl-W
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '^W' backward-kill-dir

# Word jumps
bindkey "^B" backward-word
bindkey "^F" forward-word

# Autojump
[ -f /etc/profile.d/autojump.zsh ] && source /etc/profile.d/autojump.zsh

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
base16_atelier-dune

# Use fzf for Ctrl-R search
[ -f ~/.config/fzf/key-bindings.zsh ] && source ~/.config/fzf/key-bindings.zsh
# Use fzf for completion
[ -f ~/.config/fzf/completion.zsh ] && source ~/.config/fzf/completion.zsh

# On Mac, somehow I got both of the above by sourcing this
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Aliases
alias ls=exa

# If there's a local .zshrc, source it
if [[ -s "${ZDORDIR:-$HOME}/.zshrc.local" ]]; then
  source "${ZDORDIR:-$HOME}/.zshrc.local"
fi
