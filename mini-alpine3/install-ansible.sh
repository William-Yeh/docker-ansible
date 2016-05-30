#!/bin/sh
#
# Simple wrapper for installing ansible
#


echo "===> Adding prerequisites..."

cat ___APK_INSTALL_LIST  | \
    while read ITEM; do
        apk --update add $ITEM
    done

cat ___PIP_INSTALL_LIST  | \
    while read ITEM; do
        pip install --upgrade $ITEM
    done


echo "===> Installing Ansible..."
pip install ansible


echo "===> Adding hosts for convenience..."  && \
mkdir -p /etc/ansible                        && \
echo 'localhost' > /etc/ansible/hosts
