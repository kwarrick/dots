##
# PROMPT
##
setopt prompt_subst               # Enable prompt substitutions.
autoload -U colors && colors      # Enable colors.
autoload -U promptinit            # Intialize advanced prompt support.

autoload -U select-word-style
select-word-style bash

PCOLOR=yellow
function ssh_connection() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo " %{$fg_bold[yellow]%}⚡ "
  fi
}
PROMPT="%{$fg[$PCOLOR]%}[%n%{$reset_color%}@%{$fg[$PCOLOR]%}%m %{$fg[blue]%}%1~%{$fg[$PCOLOR]%}]%{$reset_color%} ${ssh_connection} %# "
RPROMPT=""

##
# COMPLETION
##
autoload -U compinit              # Enable zsh tab-completion system.
compinit
setopt complete_in_word
setopt always_to_end
# setopt correctall
setopt list_ambiguous

# `kill' completion.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

compdef _gnu_generic gcc
compdef _gnu_generic gdb

##
# VARIABLES
##
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

##
# OPTIONS
##
setopt extended_history           # Store begging time: elapsed seconds: command.
setopt hist_expire_dups_first
setopt hist_ignore_dups           # Ignore duplication command history list.
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history              # Share command history data across terminals.
setopt no_beep
setopt extended_glob              # Treat #,~,^ as part of patterns for files.
setopt interactivecomments        # Allow comments in interactive mode.
setopt hist_ignore_space          # Ignore entries with leading spaces.

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

##
# ALIASES
##
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


##
# FUNCTIONS
##
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

##
# KEY BINDINGS
##

# bindkey -v                # Vi bindings.
# bindkey '^k' vi-cmd-mode  # Ctrl-k to NORMAL mode.

# Little bit of Emacs.
# bindkey -M viins '^a' beginning-of-line
# bindkey -M viins '^e' end-of-line
# bindkey -M viins '^r' history-incremental-pattern-search-backward
# bindkey -M viins '^u' backward-kill-line
# bindkey -M viins '^y' yank
#
# bindkey -M vicmd '^a' beginning-of-line
# bindkey -M vicmd '^e' end-of-line
# bindkey -M vicmd 'yy' vi-yank-whole-line
#
# _cut_inner_word() {
#   setopt localoptions extendedglob
#   LBUFFER=${LBUFFER%%[^ ]#}
#   RBUFFER=${RBUFFER##[^ ]#}
# }
# zle -N cut-inner-word _cut_inner_word
# bindkey '^xc' cut-inner-word
# bindkey -M vicmd 'ciw' cut-inner-word
#
# VIM mode prompt.
# function zle-line-init zle-keymap-select {
#   VIM_PROMPT="[%{$fg[yellow]%}NORMAL%{$reset_color%}]"
#   RPROMPT="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}"
#   zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select
#
# function zle-line-finish {
#   vim_mode=$vim_ins_mode
# }
# zle -N zle-line-finish

##
# PATH
##
export PATH="/usr/local/sbin:$PATH"

##
# UTILS
##

# OPAM configuration.
. /Users/warrick/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# RBENV
eval "$(rbenv init -)"

# AUTOJUMP
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# VIRTUALENV
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
source /usr/local/bin/virtualenvwrapper_lazy.sh

export HOMEBREW_GITHUB_API_TOKEN=cb429dd7a354caca211d978ffc16abaf3ffa4e03

# GO
export GOPATH=$HOME/Code/go

# DOCKER
function docker-env () {
  eval "$(docker-machine env $1)"
}
alias denv="docker-env"
denv default
alias dcocker="docker"
alias d="docker"
alias dps="docker ps -a"
alias dm="docker-machine"

