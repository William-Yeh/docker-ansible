#!/bin/sh
#
# Simple wrapper for installing ansible
#


export DEBIAN_FRONTEND=noninteractive


echo "===> Adding backports..."

mkdir -p /etc/apt/sources.list.d/
echo "deb http://ftp.debian.org/debian jessie-backports main" | tee -a /etc/apt/sources.list.d/jessie-backports.list



echo "===> Adding prerequisites..."

apt-get update -y
cat ___APT_INSTALL_LIST  | \
    while read ITEM; do
        apt-get --no-install-recommends -y install $ITEM
    done



echo "===> Installing Ansible..."
apt-get -t jessie-backports install -y ansible



echo "===> Adding hosts for convenience..."  && \
mkdir -p /etc/ansible                        && \
echo 'localhost' > /etc/ansible/hosts
