#!/bin/sh
#
# Simple wrapper for installing ansible
#


export DEBIAN_FRONTEND=noninteractive


echo "===> Adding prerequisites..."

apt-get update -y
cat ___APT_INSTALL_LIST  | \
    while read ITEM; do
        apt-get --no-install-recommends -y install $ITEM
    done



echo "===> Installing Ansible..."
apt-get --no-install-recommends -y install ansible



echo "===> Adding hosts for convenience..."  && \
mkdir -p /etc/ansible                        && \
echo 'localhost' > /etc/ansible/hosts
