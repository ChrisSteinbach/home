#!/bin/bash

source ./functions

pkginstall vim
install -D .vimrc ${HOME}/.vimrc

if ! test -d ~/.vim/bundle/Vundle.vim ; then
    echo "Installing vundle"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
fi
