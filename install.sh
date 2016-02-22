#!/bin/bash

for f in ".gdbinit .gemrc .gitconfig .msfconsole.rc .radare2rc .tmux.conf .vimrc .zshrc"
do
  cp $HOME/dotfiles/$f $HOME
done

if [ ! -d $HOME/.vim/bundle ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi
