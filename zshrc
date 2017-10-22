# PATH
################################################################################
export PATH="/usr/local/sbin:$PATH"
export EDITOR=vim

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# PROMPT
################################################################################
autoload -U promptinit
autoload -U colors
autoload -U select-word-style

promptinit
colors
select-word-style bash

prompt adam1

bindkey -e

# COMPLETION
################################################################################
autoload -U zutil
autoload -U compinit
autoload -U complist

compinit -i
zmodload -i zsh/complist

zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'


# OPTIONS
################################################################################

setopt NO_BEEP
setopt CHECK_JOBS
setopt INTERACTIVE_COMMENTS

# Glob
setopt EXTENDED_GLOB

# History
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Completion
setopt COMPLETE_IN_WORD
setopt AUTO_MENU


# ALIASES
################################################################################
if [ `uname` = "Darwin" ]; then
  alias ls="ls -G"
  alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
  alias pg_stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
  alias mysql_start="mysql.server start"
  alias mysql_stop="mysql.server stop"
  alias ida="wine ~/.wine/drive_c/Program\ Files/IDA\ 6.6/idaq.exe"
  alias ida64="wine ~/.wine/drive_c/Program\ Files/IDA\ 6.6/idaq64.exe"
  alias awk=gawk
  alias grep=ggrep
  alias sed=gsed
  alias zcat=gzcat
  alias objdump=gobjdump
  alias netstat="sudo netstat -A -n -p tcp -v -a"
else
  alias ls="ls --color=auto -G"
  alias netstat="sudo netstat -pant"
  alias update="sudo apt-get update && sudo apt-get upgrade"
fi

alias v="vim"
alias g="git"
alias f="noglob find -name"
alias scp="noglob scp"
alias ll="ls -lah"
alias gdb="gdb -q"
alias myip="dig +short @resolver1.opendns.com myip.opendns.com"

# Docker
alias denv="docker-env"
alias dcoker="docker"
alias d="docker"
alias dps="docker ps -a"
alias dm="docker-machine"


# FUNCTIONS
################################################################################
function ehd() {
	hexdump -v -e '"\\\x" 1/1 "%02x"' $1
		# 1/1: iteration count/byte count
}

if [ `uname` = "Darwin" ]; then
  funtion trash() {
    mv -v $* /Users/warrick/.Trash/;
  }
fi

function title() {
  echo -ne "\033]0;"$*"\007"
}

function tvnc() {
  ssh -t -L 5900:localhost:5900 $1 'x11vnc -localhost -display :0'
}

function hist() {
  grep "$*" ~/.zsh_history \
    | cut -d';' -f2-;
}

function docker-env () {
  eval "$(docker-machine env $*)"
}


# UTILS
################################################################################

# OPAM configuration.
# . /Users/warrick/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# RBENV
eval "$(rbenv init -)"

# PYENV
eval "$(pyenv init -)"

# AUTOJUMP
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# GO
export GOPATH=$HOME/Code/go

