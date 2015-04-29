#!/bin/bash


declare -a IMAGES=( 'ansible/ubuntu14.04-ansible:stable' 'ansible/centos7-ansible:stable'  \
         "williamyeh/ansible:debian8-onbuild"        \
         "williamyeh/ansible:debian7-onbuild"        \
         "williamyeh/ansible:ubuntu14.04-onbuild"    \
         "williamyeh/ansible:ubuntu12.04-onbuild"    \
         "williamyeh/ansible:centos7-onbuild"        \
         "williamyeh/ansible:centos6-onbuild"
       )

for image in "${IMAGES[@]}" ; do

    echo $image
    docker pull $image

done


docker images | sort