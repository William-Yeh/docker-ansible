# Dockerfile for building Debian-based image, via Ansible playbooks.
#
# @see http://docs.ansible.com/ansible/intro_installation.html#running-from-source
#
# Version  1.0
#


# pull base image
FROM debian:9

MAINTAINER William Yeh <william.pjyeh@gmail.com>

#ENV APT_LIST  apt-list


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