# Dockerfile for building Ansible image from source for CentOS 6, with as few additional software as possible.
#
# @see http://docs.ansible.com/ansible/intro_installation.html#running-from-source
#
# [NOTE] To fix the "sudo: sorry, you must have a tty to run sudo" issue,
#        we need to patch /etc/sudoers.
#        @see http://unix.stackexchange.com/questions/122616/why-do-i-need-a-tty-to-run-sudo-if-i-can-sudo-without-a-password
#        @see https://bugzilla.redhat.com/show_bug.cgi?id=1020147
#
# Version  1.0
#


# pull base image
FROM centos:centos6

MAINTAINER William Yeh <william.pjyeh@gmail.com>


RUN echo "===> Installing EPEL..."   && \
    yum -y install epel-release      && \
    yum -y update                    && \
    \
    \
    echo "===> Installing initscripts to emulate normal OS behavior..."  && \
    yum -y install initscripts   && \
    \
    \
    echo "===> Adding Ansible's prerequisites..."  && \
    yum -y install \
                gcc make  \
                python python-devel python-pip                 \
                libffi-devel openssl-devel                     \
                libxml2 libxml2-devel libxslt libxslt-devel    \
                git sudo curl                               && \
    pip install --upgrade pip  && \
    pip install --upgrade \
        pyyaml jinja2 pycrypto paramiko httplib2            && \
    \
    \
    echo "===> Downloading Ansible's source tree..."            && \
    git clone git://github.com/ansible/ansible.git --recursive  && \
    \
    \
    echo "===> Compiling Ansible..."      && \
    cd ansible                            && \
    bash -c 'source ./hacking/env-setup'  && \
    \
    \
    echo "===> Moving useful Ansible stuff to /opt/ansible ..."  && \
    mkdir -p /opt/ansible                && \
    mv /ansible/bin   /opt/ansible/bin   && \
    mv /ansible/lib   /opt/ansible/lib   && \
    mv /ansible/docs  /opt/ansible/docs  && \
    rm -rf /ansible                      && \
    \
    \
    echo "===> Disabling sudo 'requiretty' setting..."    && \
    sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers  && \
    \
    \
    echo "===> Removing unused YUM resources..."              && \
    yum -y remove epel-release gcc git python-devel python-pip \
                  libffi-devel openssl-devel  || true         && \
    yum clean all                                             && \
    \
    \
    echo "===> Adding hosts for convenience..."    && \
    mkdir -p /etc/ansible                          && \
    echo 'localhost' > /etc/ansible/hosts


ENV PATH        /opt/ansible/bin:$PATH
ENV PYTHONPATH  /opt/ansible/lib:$PYTHONPATH
ENV MANPATH     /opt/ansible/docs/man:$MANPATH


# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]
