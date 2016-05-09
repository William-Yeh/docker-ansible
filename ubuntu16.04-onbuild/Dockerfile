# Dockerfile for building Ansible image for Ubuntu 16.04 (Xenial), with as few additional software as possible.
#
# @see https://launchpad.net/~ansible/+archive/ubuntu/ansible
#
# Version  1.0
#


# pull base image
FROM ubuntu:16.04

MAINTAINER William Yeh <william.pjyeh@gmail.com>


RUN DEBIAN_FRONTEND=noninteractive  apt-get update  && \
    \
    \
    echo "===> Installing Ansible..."  && \
    apt-get install -y ansible  && \
    \
    \
    echo "===> Clean up..."              && \
    rm -rf /var/lib/apt/lists/*          && \
    \
    \
    echo "===> Adding hosts for convenience..."  && \
    echo 'localhost' > /etc/ansible/hosts


COPY ansible-playbook-wrapper /usr/local/bin/

ONBUILD  RUN  DEBIAN_FRONTEND=noninteractive  apt-get update   && \
              echo "===> Updating TLS certificates..."         && \
              apt-get install -y openssl ca-certificates

ONBUILD  WORKDIR  /tmp
ONBUILD  COPY  .  /tmp
ONBUILD  RUN  \
              echo "===> Diagnosis: host information..."  && \
              ansible -c local -m setup all



# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]
