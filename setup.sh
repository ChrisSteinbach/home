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
install sshfs
install virt-what

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
