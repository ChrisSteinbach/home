#!/bin/bash

source ./functions

pkginstall openssh-server

# Generate key if non exists
if ! test -f ${HOME}/.ssh/id_rsa ; then
    ssh-keygen -f ${HOME}/.ssh/id_rsa -t rsa -N ''
fi

if is_vm ; then
    if ! grep -sq kvmhost ${HOME}/.ssh/config ; then
    	info "Configure KVM host"
    	cat <<-EOF >> ${HOME}/.ssh/config
		# Used for kvm instances to talk to host
		Host kvmhost
	    	Hostname 192.168.122.1
	    	User    ${USER}
		EOF
    fi
    install -d ${HOME}/kvmhost
fi
