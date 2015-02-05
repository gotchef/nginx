# -*- mode: ruby -*-
# vi: set ft=ruby :

# https://docs.vagrantup.com.
# boxes at https://atlas.hashicorp.com/search.

VAGRANTFILE_VERSION = 2

Vagrant.configure(VAGRANTFILE_VERSION) do |config|
#	config.vm.box = "hashicorp/precise64"
	#config.vm.box = "kraveio/centos-6.6"
	config.vm.box = "centos-6.6-x86_64"
	#config.vm.box = "chef/centos-6.6"
	config.omnibus.chef_version = :latest
	config.berkshelf.enabled = true
	
	config.vm.provision "chef_zero" do |chef|
		chef.cookbooks_path = "../../gotchef"
#		chef.add_recipe "apt"
		chef.add_recipe "nginx::install"
		chef.add_recipe "nginx::service"
	end
end
