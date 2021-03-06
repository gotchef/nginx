#
# common config
#

runit_service "nginx" do
  action :nothing # only define so that it can be restarted if the config changed
end

template "#{node[:nginx][:conf_dir]}/nginx.conf" do
	cookbook	node[:nginx][:templates][:nginx_conf_cookbook]
	source	'nginx.conf.erb'
	owner		'root'
	group		'root'
	mode		'644'
	action	:create
	notifies :restart, 'runit_service[nginx]', :delayed
end

cookbook_file "#{node[:nginx][:conf_dir]}/mime.types" do
	source 'mime.types'
	owner  'root'
	group  'root'
	mode   '644'
	notifies :restart, 'runit_service[nginx]', :delayed
end

