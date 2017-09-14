Vagrant.configure(2) do |config|
  config.vm.box = "williamyeh/ubuntu-trusty64-docker"

  config.vm.provision "shell", inline: <<-SHELL
    cd /vagrant

    docker build  -t ansible:ubuntu16.04          ubuntu16.04
    docker build  -t ansible:ubuntu14.04          ubuntu14.04
    docker build  -t ansible:debian9              debian9
    docker build  -t ansible:debian8              debian8
    docker build  -t ansible:centos7              centos7
    docker build  -t ansible:alpine3              alpine3

    docker build  -t ansible:ubuntu16.04-onbuild  ubuntu16.04-onbuild
    docker build  -t ansible:ubuntu14.04-onbuild  ubuntu14.04-onbuild
    docker build  -t ansible:debian9-onbuild      debian9-onbuild
    docker build  -t ansible:debian8-onbuild      debian8-onbuild
    docker build  -t ansible:centos7-onbuild      centos7-onbuild
    docker build  -t ansible:alpine3-onbuild      alpine3-onbuild

  SHELL
end
