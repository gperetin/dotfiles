# This is stolen from garyberndhardt and modified
setopt promptsubst
autoload -U promptinit
promptinit
prompt grb

autoload -U compinit
compinit

# Add paths that should have been there by default
export PATH=/usr/local/sbin:/usr/local/bin:${PATH}

# Unbreak broken, non-colored terminal
export TERM='xterm-color'
alias ls='ls --color'
alias ll='ls -l --color'
alias duh='du -csh'
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export GREP_OPTIONS="--color"

# Unbreak history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

# Unbreak Python's error-prone .pyc file generation
export PYTHONDONTWRITEBYTECODE=1

export WORDCHARS='*?[]~&;!$%^<>'

export ACK_COLOR_MATCH='red'

# ACTUAL CUSTOMIZATION OH NOES!
gd() { git diff $* | view -; }
gdc() { gd --cached $*; }
alias gx="gitx"
alias gxa="gitx --all"
function mcd() { mkdir -p $1 && cd $1 }
alias :q="echo YOU FAIL"

activate_virtualenv() {
    if [ -f env/bin/activate ]; then . env/bin/activate;
    elif [ -f ../env/bin/activate ]; then . ../env/bin/activate;
    elif [ -f ../../env/bin/activate ]; then . ../../env/bin/activate;
    elif [ -f ../../../env/bin/activate ]; then . ../../../env/bin/activate;
    fi
}

python_module_dir () {
    echo "$(python -c "import os.path as _, ${1}; \
        print _.dirname(_.realpath(${1}.__file__[:-1]))"
        )"
}

export WORKON_HOME=~/.virtualenvs
alias f="fg"
alias i="ipython"
alias v="vim"

# resume Vim on ctrl+z
foreground-vi() {
  fg %vi
}
zle -N foreground-vi
bindkey '^Z' foreground-vi

bindkey '^f' forward-word
bindkey '^b' backward-word
bindkey '^q' delete-word

# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Oh my zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh
