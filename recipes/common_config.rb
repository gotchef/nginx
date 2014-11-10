#
# common config
#

service "nginx" do
  supports :restart => true, :status => true 
  action :nothing # only define so that it can be restarted if the config changed
end

template "#{node[:nginx][:conf_dir]}/nginx.conf" do
  cookbook	"nginx"
  source	'nginx.conf.erb'
  owner		'root'
  group		'root'
  mode		'644'
  action	:create
  notifies :restart, 'service[nginx]'
end

cookbook_file "#{node[:nginx][:conf_dir]}/mime.types" do
  source 'mime.types'
  owner  'root'
  group  'root'
  mode   '644'
  notifies :reload, 'service[nginx]'
end



