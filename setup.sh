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
if ! test -d ~/.vim/bundle/Vundle.vim ; then
    echo "Installing vundle"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
fi

install openssh-server
install gitk

git config core.editor vim
git config --global credential.helper 'cache --timeout=86400'
