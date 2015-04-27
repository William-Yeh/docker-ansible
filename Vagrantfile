Vagrant.configure(2) do |config|
  config.vm.box = "williamyeh/ubuntu-trusty64-docker"

  config.vm.provision "shell", inline: <<-SHELL
    cd /vagrant

    docker build  -t ansible:ubuntu14.04  ubuntu14.04
    docker build  -t ansible:ubuntu12.04  ubuntu12.04
    docker build  -t ansible:debian7      debian7
  SHELL
end
