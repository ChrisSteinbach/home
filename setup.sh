#!/bin/bash

source ./functions

if ! test -f ./setup.sh ; then
	err "Please run from 'home' repository root"
	exit 1
fi


install -D ./functions ${HOME}/bin/functions

install/vim.sh
install/openssh.sh
pkginstall gitk
pkginstall sshfs
pkginstall virt-what
pkginstall curl
pkginstall ack-grep

git config core.editor vim
git config --global credential.helper 'cache --timeout=86400'
