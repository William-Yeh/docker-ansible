# Dockerfile for building Ansible image for Alpine 3, with as few additional software as possible.
#
# @see https://github.com/gliderlabs/docker-alpine/blob/master/docs/usage.md
#
# Version  1.0
#


# pull base image
FROM alpine:3.8

MAINTAINER William Yeh <william.pjyeh@gmail.com>


RUN echo "===> Installing sudo to emulate normal OS behavior..."  && \
    apk --update add sudo                                         && \
    \
    \
    echo "===> Adding Python runtime..."  && \
    apk --update add python py-pip openssl ca-certificates    && \
    apk --update add --virtual build-dependencies \
                python-dev libffi-dev openssl-dev build-base  && \
    pip install --upgrade pip    &&  \
    pip install --no-cache-dir --upgrade cffi                            && \
    \
    \
    echo "===> Installing Ansible..."  && \
    pip install --no-cache-dir ansible                && \
    \
    \
    echo "===> Installing handy tools (not absolutely required)..."  && \
    pip install --no-cache-dir --upgrade pycrypto pywinrm         && \
    apk --update add sshpass openssh-client rsync  && \
    \
    \
    echo "===> Removing package list..."  && \
    apk del build-dependencies            && \
    rm -rf /var/cache/apk/*               && \
    \
    \
    echo "===> Adding hosts for convenience..."  && \
    mkdir -p /etc/ansible                        && \
    echo 'localhost' > /etc/ansible/hosts


# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]
