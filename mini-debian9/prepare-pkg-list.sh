#!/bin/sh
#
# Prepare the list of packages to be installed/uninstalled.
#
# ENVIRONMENT VARIABLES:
#
#    - APT_LIST: APT package list;  default = "apt-list"
#

echo "===> Preparing APT package list..."

if [ -z "$APT_LIST" ]; then
    APT_LIST=apt-list
fi

if [ -f "$APT_LIST" ]; then

    awk '/^#/ {next}                                 \
         { split($0,arrayA);                         \
           for (i in arrayA) {                       \
              if (arrayA[i] == "!") { continue; }    \
              print arrayA[i]                        \
           }                                         \
         }'                                          \
        $APT_LIST > ___APT_INSTALL_LIST

    awk '/^(#|!)/ {next}                                          \
         { split($0,arrayA); for (i in arrayA) print arrayA[i] }' \
        $APT_LIST  |
        awk '{ L[n++] = $0 }          \
                END { while(n--)      \
                      print L[n] }'   \
            > ___APT_UNINSTALL_LIST

fi
#cat ___APT_INSTALL_LIST
#cat ___APT_UNINSTALL_LIST
