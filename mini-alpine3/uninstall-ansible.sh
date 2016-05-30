#!/bin/sh
#
# Simple wrapper for uninstall ansible and related stuff.
#


echo "===> Removing Ansible..."
pip uninstall -y ansible

echo "===> Removing PIP packages..."
cat ___PIP_UNINSTALL_LIST  | \
    while read ITEM; do
        pip uninstall -y $ITEM
    done

echo "===> Removing APK packages..."
cat ___APK_UNINSTALL_LIST  | \
    while read ITEM; do
        apk del $ITEM
    done


echo "===> Cleaning up package list..."
rm -rf /var/lib/python2.7  /usr/lib/python2.7
rm -rf /etc/ansible  /root/.ansible  /root/.cache  /root/.ash_history
rm -rf /var/cache/apk
