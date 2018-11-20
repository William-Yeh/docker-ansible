# Dockerfile for building Alpine-based image, via Ansible playbooks.
#
# @see https://github.com/gliderlabs/docker-alpine/blob/master/docs/usage.md
#
# Version  1.0
#


# pull base image
FROM alpine:3.8

MAINTAINER William Yeh <william.pjyeh@gmail.com>

#ENV APK_LIST  apk-list
#ENV PIP_LIST  pip-list


COPY  .  /tmp

ONBUILD COPY . /tmp
ONBUILD RUN \
    cd /tmp                     && \
    ./prepare-pkg-list.sh       && \
    ./install-ansible.sh        && \
    ./ansible-playbook-wrapper  && \
    ./uninstall-ansible.sh      && \
    cd /                        && \
    rm -rf /tmp/*
