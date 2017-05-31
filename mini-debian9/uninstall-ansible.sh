#!/bin/sh
#
# Simple wrapper for uninstall ansible and related stuff.
#


echo "===> Removing Ansible..."
apt-get -f -y --auto-remove remove ansible

echo "===> Removing APT packages..."
cat ___APT_UNINSTALL_LIST  | \
    while read ITEM; do
        apt-get -f -y --auto-remove remove $ITEM
    done
apt-get clean


echo "===> Cleaning up package list..."
rm -rf /etc/python  /etc/python2.7
rm -rf /etc/ansible  /root/.ansible  /root/.cache 
rm -rf /var/lib/apt/lists/*  /etc/apt/sources.list.d  /var/cache/*  /var/log/*
