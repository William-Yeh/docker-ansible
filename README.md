Docker-Ansible base images
===================


## Summary

Repository name in Docker Hub: **[williamyeh/ansible](https://registry.hub.docker.com/u/williamyeh/ansible/)**

This repository contains Dockerized [Ansible](https://github.com/ansible/ansible), published to the public [Docker Hub](https://registry.hub.docker.com/) via **automated build** mechanism.



## Configuration

These are Docker images for [Ansible](https://github.com/ansible/ansible) software, installed in a selected Linux distributions.

- OS: Debian (jessie, wheezy), Ubuntu (trusty, precise).

- Ansible: usually the latest version.


## Images and tags

- normal series:

  - `williamyeh/ansible:debian8`
  - `williamyeh/ansible:debian7`
  - `williamyeh/ansible:ubuntu14.04`
  - `williamyeh/ansible:ubuntu12.04`

- onbuild series:

  - `williamyeh/ansible:debian8-onbuild`
  - `williamyeh/ansible:debian7-onbuild`
  - `williamyeh/ansible:ubuntu14.04-onbuild`
  - `williamyeh/ansible:ubuntu12.04-onbuild`


## Why yet another Ansible image for Docker?

There has been quite a few Ansible images for Docker (e.g., [search](https://registry.hub.docker.com/search?q=ansible) in the Docker Hub), so why reinvent the wheel?

In the beginning I used the [`ansible/ansible-docker-base`](https://github.com/ansible/ansible-docker-base) created by Ansible Inc. It worked well, but left some room for improvement:

- *Base OS image* - It provides only `centos:centos7` and `ubuntu:14.04`.  Insufficent for me.

- *Unnecessary dependencies* - It installed, at the very beginning of its Dockerfile, the `software-properties-common` package, which in turns installed some Python packages. I prefered to incorporate these stuff only when absolutely needed.

Therefore, I built these Docker images on my own.


## Usage

Used mostly as a *base image* for configuring, with Ansible, other software stack on some specified Linux distribution.

Take Debian/Ubuntu for example. To test an Ansible `playbook.yml` against a variety of Linux distributions, we may use [Vagrant](https://www.vagrantup.com/) as follows:

```ruby
# Vagrantfile

Vagrant.configure(2) do |config|

    # ==> Choose a Vagrant box to emulate Linux distribution...
    config.vm.box = "ubuntu/trusty64"
    #config.vm.box = "hashicorp/precise64"
    #config.vm.box = "chef/debian-7.8"

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
FROM williamyeh/ansible:ubuntu14.04
#FROM williamyeh/ansible:ubuntu12.04
#FROM williamyeh/ansible:debian8
#FROM williamyeh/ansible:debian7


# ==> Copying Ansible playbook...
WORKDIR /tmp
COPY  .  /tmp

# ==> Creating inventory file...
RUN echo localhost > inventory

# ==> Executing Ansible...
RUN ansible-playbook -i inventory playbook.yml \
      --connection=local --sudo
```

Or, more simple with `onbuild` series:

```dockerfile
# Dockerfile

# ==> Choose a base image to emulate Linux distribution...
FROM williamyeh/ansible:ubuntu14.04-onbuild
#FROM williamyeh/ansible:ubuntu12.04-onbuild
#FROM williamyeh/ansible:debian8-onbuild
#FROM williamyeh/ansible:debian7-onbuild


# ==> Specify playbook filename;   default = "playbook.yml"
#ENV PLAYBOOK   playbook.yml

# ==> Specify inventory filename;  default = "/etc/ansible/hosts"
#ENV INVENTORY  inventory.ini

# ==> Executing Ansible...
RUN ansible-playbook-wrapper
```



With Docker, we can test any Ansible playbook against any version of any Linux distribution without the help of Vagrant. More lightweight, and more portable across IaaS, PaaS, and even CaaS (Container as a Service) providers!

If better OS emulation (virtualization) isn't required, the Docker approach (containerization) should give you a more efficient Ansible experience.



## License

Author: William Yeh <william.pjyeh@gmail.com>

Licensed under the Apache License V2.0. See the [LICENSE file](LICENSE) for details.
