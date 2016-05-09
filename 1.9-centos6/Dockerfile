# Dockerfile for building Ansible 1.9 image for CentOS 6, with as few additional software as possible.
#
# @see http://docs.ansible.com/intro_installation.html#latest-release-via-yum
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


RUN echo "===> Installing EPEL..."        && \
    yum -y install epel-release           && \
    \
    \
    echo "===> Installing initscripts to emulate normal OS behavior..."  && \
    yum -y install initscripts sudo                                      && \
    \
    \
    echo "===> Adding Ansible's prerequisites..."  && \
    yum -y install gcc python-devel python-pip  \
                       libffi-devel openssl-devel  && \
    pip install --upgrade pip                      && \                 
    \
    \
    echo "===> Installing Ansible..."     && \
    pip install --upgrade ansible==1.9.4  && \
    \
    \
    echo "===> Disabling sudo 'requiretty' setting..."    && \
    sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers  || true  && \
    \
    \
    echo "===> Removing unused YUM resources..."             && \
    yum -y remove epel-release gcc python-devel python-pip \
                  libffi-devel openssl-devel  || true        && \
    yum clean all                                            && \
    \
    \
    echo "===> Adding hosts for convenience..."    && \
    mkdir -p /etc/ansible                          && \
    echo 'localhost' > /etc/ansible/hosts


# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]
