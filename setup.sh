#!/bin/bash

install() {
   local pkg=$1
   sudo apt install -y ${pkg}
}

copy_if_missing() {
  if ! test -f $1 ; then
      echo "Copying $1 to home directory"
      cp $1 ${HOME}/.vimrc
  fi
}

install vim
copy_if_missing .vimrc
if ! test -f ~/.vim/bundle/Vundle.vim ; then
    echo "Installing vundle"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
fi

install openssh-server

git config core.editor vim
