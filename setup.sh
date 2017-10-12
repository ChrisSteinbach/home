#!/bin/bash

install() {
   local pkg=$1
   sudo apt install -y ${pkg}
}

install vim
install openssh-server

git config core.editor vim
