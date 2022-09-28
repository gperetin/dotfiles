# Terminal driver settings
# Don't use suspend
stty stop ^-

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

# Add to PATH
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"


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

suspended-jobs() {
  local numsuspendedjobs=`jobs | wc -l`
  if [ $numsuspendedjobs != '0' ]; then
      echo "💤 "
  fi
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
PROMPT='$(suspended-jobs)%F{magenta}%1~$(git-prompt-info)%f ❯ '

# More history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

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

# Use fzf for Ctrl-R search
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
# Use fzf for completion
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# Alias to quickly view file
alias vf="fzf --bind 'ctrl-v:execute(vim {})+abort' --preview 'bat --style=numbers --color=always {}' --preview-window up:70%"

alias e="nvim"

# Use git ls-tree for fast search in a git repo
export FZF_DEFAULT_COMMAND='
  (git ls-tree -r --name-only HEAD ||
   find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
      sed s/^..//) 2> /dev/null'

# If there's a local .zshrc, source it
if [[ -s "${ZDORDIR:-$HOME}/.zshrc.local" ]]; then
  source "${ZDORDIR:-$HOME}/.zshrc.local"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/goran/google-cloud-sdk/path.zsh.inc' ]; then . '/home/goran/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/goran/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/goran/google-cloud-sdk/completion.zsh.inc'; fi

eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
