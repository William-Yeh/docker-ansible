#!/bin/sh
#
# Prepare the list of packages to be installed/uninstalled.
#
# ENVIRONMENT VARIABLES:
#
#    - APK_LIST: APK package list;  default = "apk-list"
#    - PIP_LIST: PIP package list;  default = "pip-list"
#

echo "===> Preparing APK package list..."

if [ -z "$APK_LIST" ]; then
    APK_LIST=apk-list
fi

if [ -f "$APK_LIST" ]; then

    awk '/^#/ {next}                                 \
         { split($0,arrayA);                         \
           for (i in arrayA) {                       \
              if (arrayA[i] == "!") { continue; }    \
              print arrayA[i]                        \
           }                                         \
         }'                                          \
        $APK_LIST > ___APK_INSTALL_LIST

    awk '/^(#|!)/ {next}                                          \
         { split($0,arrayA); for (i in arrayA) print arrayA[i] }' \
        $APK_LIST  |
        awk '{ L[n++] = $0 }          \
                END { while(n--)      \
                      print L[n] }'   \
            > ___APK_UNINSTALL_LIST

fi
#cat ___APK_INSTALL_LIST
#cat ___APK_UNINSTALL_LIST


echo "===> Preparing PIP package list..."

if [ -z "$PIP_LIST" ]; then
    PIP_LIST=pip-list
fi

if [ -f "$PIP_LIST" ]; then

    awk '/^#/ {next}                                 \
         { split($0,arrayA);                         \
           for (i in arrayA) {                       \
              if (arrayA[i] == "!") { continue; }    \
              print arrayA[i]                        \
           }                                         \
         }'                                          \
        $PIP_LIST > ___PIP_INSTALL_LIST

    awk '/^(#|!)/ {next}                                          \
         { split($0,arrayA); for (i in arrayA) print arrayA[i] }' \
        $PIP_LIST  |
        awk '{ L[n++] = $0 }          \
                END { while(n--)      \
                      print L[n] }'   \
            > ___PIP_UNINSTALL_LIST

fi
#cat ___PIP_INSTALL_LIST
#cat ___PIP_UNINSTALL_LIST
