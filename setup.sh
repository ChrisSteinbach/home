#!/bin/bash

source ./functions

if ! test -f ./setup.sh ; then
	err "Please run from 'home' repository root"
	exit 1
fi


install -D ./functions ${HOME}/bin/functions

install/vim.sh
pkginstall openssh-server
pkginstall gitk
pkginstall sshfs
pkginstall virt-what
pkginstall curl
pkginstall ack-grep

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
    mkdir ${HOME}/kvmhost
fi
