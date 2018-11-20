Docker-Ansible base images
===================

[![Circle CI](https://circleci.com/gh/William-Yeh/docker-ansible.svg?style=shield)](https://circleci.com/gh/William-Yeh/docker-ansible) [![Build Status](https://travis-ci.org/William-Yeh/docker-ansible.svg?branch=master)](https://travis-ci.org/William-Yeh/docker-ansible)


## Summary

Repository name in Docker Hub: **[williamyeh/ansible](https://hub.docker.com/r/williamyeh/ansible/)**

This repository contains Dockerized [Ansible](https://github.com/ansible/ansible), published to the public [Docker Hub](https://hub.docker.com/) via **automated build** mechanism.



## Configuration

These are Docker images for [Ansible](https://github.com/ansible/ansible) software, installed in a selected Linux distributions.

### Base OS

Debian (stretch, jessie), Ubuntu (bionic, xenial, trusty), CentOS (7), Alpine (3).

Supports for Wheezy, Precise, and CentOS6 have been ended since Sep 2017.

### Ansible

Four versions are provided:

  1. provides the most recent *stable* version of Ansible; suitable for most people.
  2. same as stable version, but is designed for building (near-)*minimal* images out of playbooks; i.e., the Ansible body will be removed when mission completed. Refer to “[Build Docker images with Ansible: A half-blood approach](https://github.com/William-Yeh/build-docker-with-ansible)” for working examples and slides.
  3. provides the old 1.9 version of Ansible (but will be retired someday).
  4. provides the *experimental* version of Ansible; i.e., the master branch of official [Ansible's git repo](https://github.com/ansible/ansible).

Each version is further divided into two variants:

- *Normal* variant: intended to be used as Ansible *control machines*, or in cases that is inadequate in the onbuild variants.
- *Onbuild* variant: intended to be used to build Docker images.


## Images and tags

### Stable version (installed from official PyPI repo):

- Normal variants:

  - `williamyeh/ansible:debian9`
  - `williamyeh/ansible:debian8`
  - `williamyeh/ansible:ubuntu18.04`
  - `williamyeh/ansible:ubuntu16.04`
  - `williamyeh/ansible:ubuntu14.04`
  - `williamyeh/ansible:centos7`
  - `williamyeh/ansible:alpine3`

- Onbuild variants (*recommended for common cases*):

  - `williamyeh/ansible:debian9-onbuild`
  - `williamyeh/ansible:debian8-onbuild`
  - `williamyeh/ansible:ubuntu18.04-onbuild`
  - `williamyeh/ansible:ubuntu16.04-onbuild`
  - `williamyeh/ansible:ubuntu14.04-onbuild`
  - `williamyeh/ansible:centos7-onbuild`
  - `williamyeh/ansible:alpine3-onbuild`


### Minimal configuration (the Ansible body will be removed when mission completed):

Refer to “[Build Docker images with Ansible: A half-blood approach](https://github.com/William-Yeh/build-docker-with-ansible)” for working examples and slides.

- Onbuild variants:

  - `williamyeh/ansible:mini-alpine3`
  - `williamyeh/ansible:mini-debian9`
  - `williamyeh/ansible:mini-debian8`


### Old 1.9 version (will be retired someday):

Note: Ansible 1.9 was not supported in CentOS EPEL since January 2017, according to [this announcement](http://www.spinics.net/linux/fedora/epel-devel/msg00792.html).

- Normal variants:

  - `williamyeh/ansible:1.9-debian8`
  - `williamyeh/ansible:1.9-ubuntu14.04`
  - `williamyeh/ansible:1.9-alpine3`

- Onbuild variants (*recommended for common cases*):

  - `williamyeh/ansible:1.9-debian8-onbuild`
  - `williamyeh/ansible:1.9-ubuntu14.04-onbuild`
  - `williamyeh/ansible:1.9-alpine3-onbuild`


### Experimental version (building directly from the git `master` source tree; use at your own risk!):

- Normal variants:

  - `williamyeh/ansible:master-debian9`
  - `williamyeh/ansible:master-debian8`
  - `williamyeh/ansible:master-ubuntu18.04`
  - `williamyeh/ansible:master-ubuntu16.04`
  - `williamyeh/ansible:master-centos7`

- Onbuild variants (*recommended for common cases*):

  - `williamyeh/ansible:master-debian9-onbuild`
  - `williamyeh/ansible:master-debian8-onbuild`
  - `williamyeh/ansible:master-ubuntu18.04-onbuild`
  - `williamyeh/ansible:master-ubuntu16.04-onbuild`
  - `williamyeh/ansible:master-centos7-onbuild`



## For the impatient

Here comes a simplest working example for the impatient.

First, choose a base image you'd like to begin with. For example, `williamyeh/ansible:ubuntu16.04-onbuild`.

Second, put the following `Dockerfile` along with your playbook directory:

```
FROM williamyeh/ansible:ubuntu16.04-onbuild

# ==> Specify requirements filename;  default = "requirements.yml"
#ENV REQUIREMENTS  requirements.yml

# ==> Specify playbook filename;      default = "playbook.yml"
#ENV PLAYBOOK      playbook.yml

# ==> Specify inventory filename;     default = "/etc/ansible/hosts"
#ENV INVENTORY     inventory.ini

# ==> Executing Ansible (with a simple wrapper)...
RUN ansible-playbook-wrapper
```

Third, `docker build .`

Done!

For more advanced usage, the role in Ansible Galaxy [`williamyeh/nginx`](https://galaxy.ansible.com/williamyeh/nginx/) demonstrates how to perform a simple smoke test (*configuration needs test, too!*) on a variety of (*containerized*) Linux distributions on [CircleCI](https://circleci.com/)'s Ubuntu 12.04 and [Travis CI](https://travis-ci.org/)’s Ubuntu 14.04 worker instances.




## Why yet another Ansible image for Docker?

There has been quite a few Ansible images for Docker (e.g., [search](https://hub.docker.com/search/?isAutomated=1&isOfficial=0&page=1&pullCount=0&q=ansible&starCount=0) in the Docker Hub), so why reinvent the wheel?

In the beginning I used the [`ansible/ansible-docker-base`](https://github.com/ansible/ansible-docker-base) created by Ansible Inc. It worked well, but left some room for improvement:

- *Base OS image* - It provides only `centos:centos7` and `ubuntu:14.04`.  Insufficent for me.

- *Unnecessary dependencies* - It installed, at the very beginning of its Dockerfile, the `software-properties-common` package, which in turns installed some Python packages. I prefered to incorporate these stuff only when absolutely needed.

Therefore, I built these Docker images on my own.

**NOTE:** [`ansible/ansible-docker-base`](https://github.com/ansible/ansible-docker-base) announced in September 2015: “Ansible no longer maintains images in Dockerhub directly.”

### Comparison: image size

```
REPOSITORY                    TAG                   VIRTUAL SIZE
---------------------------   -------------------   ------------
ansible/centos7-ansible       stable                367.5 MB
ansible/ubuntu14.04-ansible   stable                286.6 MB

williamyeh/ansible            alpine3-onbuild        66.4 MB
williamyeh/ansible            centos6-onbuild       264.2 MB
williamyeh/ansible            centos7-onbuild       275.3 MB
williamyeh/ansible            debian7-onbuild       134.4 MB
williamyeh/ansible            debian8-onbuild       178.3 MB
williamyeh/ansible            ubuntu12.04-onbuild   181.9 MB
williamyeh/ansible            ubuntu14.04-onbuild   238.3 MB
```


## Usage

Used mostly as a *base image* for configuring other software stack on some specified Linux distribution(s).

Take Debian/Ubuntu/CentOS for example. To test an Ansible `playbook.yml` against a variety of Linux distributions, we may use [Vagrant](https://www.vagrantup.com/) as follows:

```ruby
# Vagrantfile

Vagrant.configure(2) do |config|

    # ==> Choose a Vagrant box to emulate Linux distribution...
    config.vm.box = "ubuntu/xenial64"
    #config.vm.box = "ubuntu/trusty64"
    #config.vm.box = "debian/stretch64"
    #config.vm.box = "debian/jessie64"
    #config.vm.box = "bento/centos-7.2"
    #config.vm.box = "maier/alpine-3.3.1-x86_64"


    # ==> Executing Ansible...
    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "playbook.yml"
    end

end
```

Virtual machines can emulate a variety of Linux distributions with good quality, at the cost of runtime overhead.


Docker to be a rescue. Now, with these **williamyeh/ansible** series, we may test an Ansible `playbook.yml` against a variety of Linux distributions as follows:


```dockerfile
# Dockerfile

# ==> Choose a base image to emulate Linux distribution...
FROM williamyeh/ansible:ubuntu16.04
#FROM williamyeh/ansible:ubuntu14.04
#FROM williamyeh/ansible:debian9
#FROM williamyeh/ansible:debian8
#FROM williamyeh/ansible:centos7
#FROM williamyeh/ansible:alpine3


# ==> Copying Ansible playbook...
WORKDIR /tmp
COPY  .  /tmp

# ==> Creating inventory file...
RUN echo localhost > inventory

# ==> Executing Ansible...
RUN ansible-playbook -i inventory playbook.yml \
      --connection=local --sudo
```

You may also work with `onbuild` variants, which take care of many routine steps for you:

```dockerfile
# Dockerfile

# ==> Choose a base image to emulate Linux distribution...
FROM williamyeh/ansible:ubuntu16.04-onbuild
#FROM williamyeh/ansible:ubuntu14.04-onbuild
#FROM williamyeh/ansible:debian9-onbuild
#FROM williamyeh/ansible:debian8-onbuild
#FROM williamyeh/ansible:centos7-onbuild
#FROM williamyeh/ansible:alpine3-onbuild


# ==> Specify requirements filename;  default = "requirements.yml"
#ENV REQUIREMENTS  requirements.yml

# ==> Specify playbook filename;      default = "playbook.yml"
#ENV PLAYBOOK      playbook.yml

# ==> Specify inventory filename;     default = "/etc/ansible/hosts"
#ENV INVENTORY     inventory.ini

# ==> Executing Ansible (with a simple wrapper)...
RUN ansible-playbook-wrapper
```



With Docker, we can test any Ansible playbook against any version of any Linux distribution without the help of Vagrant. More lightweight, and more portable across IaaS, PaaS, and even CaaS (Container as a Service) providers!

If better OS emulation (virtualization) isn't required, the Docker approach (containerization) should give you a more efficient Ansible experience.



## License

Author: William Yeh <william.pjyeh@gmail.com>

Licensed under the Apache License V2.0. See the [LICENSE file](LICENSE) for details.
