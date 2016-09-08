# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/trusty64"
  # config.vm.box = "centos/atomic-host"

  config.vm.network "private_network", ip: "192.168.33.10"

  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get -y install curl xauth
    curl -fsSL https://get.docker.com/ | sh
    usermod -aG docker vagrant
    curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    echo "source /vagrant/startup.sh" >> /home/vagrant/.bashrc
  SHELL
end
