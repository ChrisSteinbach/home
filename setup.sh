#!/bin/bash

if ! test -f ./functions ; then
	echo "Please run from 'home' repository root" >&2
	exit 1
fi

. ./functions

if ! test -d ${HOME}/bin ; then
	echo "Create bin directory"
	mkdir ${HOME}/bin
fi

copy_if_missing functions ${HOME}/bin

install ack-grep
install vim
copy_if_missing .vimrc
if ! test -d ~/.vim/bundle/Vundle.vim ; then
    echo "Installing vundle"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
fi

install openssh-server
install gitk
install sshfs
install virt-what
install curl

git config core.editor vim
git config --global credential.helper 'cache --timeout=86400'

if ! test -f ${HOME}/.ssh/id_rsa ; then
    ssh-keygen -f ${HOME}/.ssh/id_rsa -t rsa -N ''
fi

# TODO: Use virt-what to check if this is a kvm or not
if ! grep -sq kvmhost ${HOME}/.ssh/config ; then
    echo "Configure KVM host"
    cat <<-EOF >> ${HOME}/.ssh/config
	# Used for kvm instances to talk to host
	Host kvmhost
	    Hostname 192.168.122.1
	    User    ${USER}
	    ForwardX11      yes
EOF
fi
