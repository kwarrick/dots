#!/bin/bash

files=".zshrc .zsh .vimrc .vim .gitconfig .screenrc .gdbinit"
dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for file in $files; do
  mv -nv $file{,.old}
  ln -sv "$(find $dir -name $f)" ~/$f
done
