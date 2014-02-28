for f in ~/.zsh/libs/*; do
  source $f
done

###############
#   PROMPT    #
###############

setopt completealiases
setopt PROMPT_SUBST
autoload -U compinit promptinit
autoload -U colors && colors
compinit -i
promptinit

function ssh_connection() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo " %{$fg_bold[yellow]%}⚡ "
  fi
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[white]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} ●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

git_custom_status() {
  local cb=$(current_branch)
  if [ -n "$cb" ]; then
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

source ~/.zsh/prompt

chpwd() { source ~/.zsh/prompt }

###############
#   ALIASES   #
###############

if [ `uname` = "Darwin" ]; then
  alias ls="ls -G"
  alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
  alias pg_stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
  alias mysql_start="mysql.server start"
  alias mysql_stop="mysql.server stop"
else
  alias ls="ls --color=auto -G"
fi

alias l=ls
alias ll="ls -lah"
alias gdb="gdb -q"

###############
#  FUNCTIONS  #
###############

ehd() {
	hexdump -v -e '"\\\x" 1/1 "%02x"' $1
		# 1/1: iteration count/byte count
}

if [ `uname` = "Darwin" ]; then
  trash() {
    mv -v $* /Users/warrick/.Trash/;
  }	
fi

title() {
  echo -ne "\033]0;"$*"\007"
}

tvnc() {
  ssh -t -L 5900:localhost:5900 $1 'x11vnc -localhost -display :0'
}

###############
#    PATH     #
###############

PATH=/usr/local/bin:/usr/local/sbin:$PATH
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$(ruby -rubygems -e "puts Gem.user_dir")/bin
PATH=/usr/local/share/python:$PATH

###############
#   OPTIONS   #
###############

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups           # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history              # share command history data

setopt no_beep
setopt complete_in_word
setopt extended_glob

setopt nullglob

setopt interactivecomments

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

#########################
#   VI/EMACS BINDINGS   #
#########################

bindkey -v

bindkey '^k' vi-cmd-mode 

bindkey -M viins '^a' beginning-of-line
bindkey -M viins '^e' end-of-line
bindkey -M viins '^r' history-incremental-pattern-search-backward
bindkey -M viins '^u' backward-kill-line
bindkey -M viins '^y' yank

bindkey -M vicmd '^a' beginning-of-line
bindkey -M vicmd '^e' end-of-line
bindkey -M vicmd 'yy' vi-yank-whole-line

_cut_inner_word() {
  setopt localoptions extendedglob
  LBUFFER=${LBUFFER%%[^ ]#}
  RBUFFER=${RBUFFER##[^ ]#}
}
zle -N cut-inner-word _cut_inner_word
bindkey '^xc' cut-inner-word
bindkey -M vicmd 'ciw' cut-inner-word

if [ ! `uname` = "Darwin" ]; then
  xmodemap -e 'clear Lock' -e 'keycode 0x42 = Escape'
fi

# EOF 
