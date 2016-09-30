#!/bin/bash

for f in ".gdbinit .gemrc .gitconfig .irbrc .msfconsole.rc .radare2rc .tmux.conf .vimrc .zshrc"
do
  cp $HOME/dotfiles/$f $HOME
done

if [ ! -d $HOME/.vim/bundle ]; then
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
  chmod +x installer.sh
  ./installer.sh $HOME/.vim
  mkdir $HOME/config
  ln -s $HOME/.vim $HOME/.config/nvim
  ln -s $HOME/.vimrc $HOME/.vim/init.vim
  rm installer.sh
fi
