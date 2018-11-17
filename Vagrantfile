# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "master" do |master|
    #master.vm.box = "ubuntu/trusty64"
    master.vm.box = "elastic/ubuntu-16.04-x86_64"
    master.vm.hostname = 'master'
    #master.vm.box_url = "ubuntu/trusty64"
    master.vm.box_url = "elastic/ubuntu-16.04-x86_64"
    master.vm.provision :"shell", path: "master_setup.sh"
    master.vm.synced_folder "./configs", "/vagrant"
    master.vm.network :private_network, ip: "192.168.254.12"
    master.vm.network :forwarded_port, guest: 22, host: 10122, id: "ssh"
    master.vm.network "forwarded_port", host: 9200, guest: 9200 # Elasticsearch

    master.vm.provider :virtualbox do |v|
      v.cpus = 1
      v.memory = 4096
      v.gui = false
    end
  end

  config.vm.define "agent" do |agent|
    #agent.vm.box = "ubuntu/trusty64"
    agent.vm.box = "elastic/ubuntu-16.04-x86_64"
    agent.vm.hostname = 'agent'
    #agent.vm.box_url = "ubuntu/trusty64"
    agent.vm.box_url = "elastic/ubuntu-16.04-x86_64"
    #agent.vm.provision :"shell", path:"agent_setup.sh"
    agent.vm.synced_folder "./", "/vagrant"
    agent.vm.network :private_network, ip: "192.168.254.13"
    agent.vm.network :forwarded_port, guest: 22, host: 1234, id: "ssh"
    agent.vm.network "forwarded_port", host: 9300, guest: 9300 # Elasticsearch
    agent.vm.network "forwarded_port", host: 5000, guest: 5000 # Logtash
    agent.vm.network "forwarded_port", host: 5601, guest: 5601 # Kibana

    agent.vm.provider :virtualbox do |v|
      v.cpus = 1
      v.memory = 4096
      v.gui = false
    end
  end

end