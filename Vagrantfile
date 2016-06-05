# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define 'web' do |machine|
    machine.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048"]
    end

    machine.vm.hostname = "web.com"
    machine.vm.network :private_network, ip: "192.168.99.102"
    machine.vm.box = "centos/7"
    machine.vm.network "forwarded_port", guest: 80, host: 8081
  end

#  config.vm.provision :ansible do |ansible|
#    ansible.playbook = "site.yml"
#    ansible.verbose = "vvvv"
#    ansible.inventory_path = "./inventories/dev.inv"
#  end

end
