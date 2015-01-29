# -*- mode: ruby -*-
# vi: set ft=ruby :

# https://docs.vagrantup.com.
# boxes at https://atlas.hashicorp.com/search.

VAGRANTFILE_VERSION = 2

Vagrant.configure(VAGRANTFILE_VERSION) do |config|
	config.vm.box = "centos-6.6-x86_64"
	#	# chef/centos-6.5"
#	config.vm.box = "hashicorp/precise64"
	config.vm.provider "virtualbox" do |v|
		v.memory = 1024
		v.cpus = 4
	end
	config.vm.provider "vmware_fusion" do |v|
		v.vmx["memsize"] = "1024"
		v.vmx["numvcpus"] = "2"
	end
	config.omnibus.chef_version = :latest
	config.berkshelf.enabled = true
	
	config.vm.provision "chef_zero" do |chef|
		chef.cookbooks_path = "../../gotchef"
#		chef.add_recipe "apt"
		chef.add_recipe "nginx::install"
		chef.add_recipe "nginx::service"
	end
end
