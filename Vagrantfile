# -*- mode: ruby -*-
# vi: set ft=ruby :

# https://docs.vagrantup.com.
# boxes at https://atlas.hashicorp.com/search.

VAGRANTFILE_VERSION = 2

Vagrant.configure(VAGRANTFILE_VERSION) do |config|
	config.vm.box = "chef/centos-7.0"
	config.vm.provider "virtualbox" do |v|
		v.memory = 1024
		v.cpus = 2
	end
	config.vm.provider "vmware_fusion" do |v|
		v.vmx["memsize"] = "1024"
		v.vmx["numvcpus"] = "2"
	end
	config.omnibus.chef_version = :latest
	config.berkshelf.enabled = true
	
	config.vm.provision "chef_zero" do |chef|
		chef.add_recipe "nginx::install"
		chef.add_recipe "nginx::service"
	end
end
