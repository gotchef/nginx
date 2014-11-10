# example config
#
#
include_recipe 'runit'

runit_service "nginx" do
  supports :restart => true, :status => true 
  action :nothing # only define so that it can be restarted if the config changed
end

template "#{node[:nginx][:conf_dir]}/conf.d/yourconfig.conf" do
	cookbook	"nginx-yourcookbook"
	source		"yourconfig.erb"
    owner		node[:nginx][:user]
    group		node[:nginx][:group]
    mode		"644"
	notifies	:reload, "runit_service[nginx]"
    variables({
		:hosts => []
    })
	notifies :restart, "runit_service[nginx]"
end

directory node[:nginx][:yourapp][:log_dir] do
  mode      '0755'
  owner     node[:nginx][:user]
  group     node[:nginx][:group]
  action    :create
  recursive true
end

