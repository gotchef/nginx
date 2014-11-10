
directory node[:nginx][:conf_dir] do
  owner     'root'
  group     'root'
  mode      '0755'
  recursive true
end

directory node[:nginx][:log_dir] do
  mode      '0755'
  owner     node[:nginx][:user]
  action    :create
  recursive true
end

directory File.dirname(node[:nginx][:pid]) do
  owner     'root'
  group     'root'
  mode      '0755'
  recursive true
end

%w(conf.d sites-enabled).each do |leaf|
  directory File.join(node[:nginx][:conf_dir], leaf) do
    owner 'root'
    group 'root'
	recursive true
    mode  '0755'
  end
end

%w(/var/lib/nginx/tmp/client_body
/var/lib/nginx/tmp/proxy 
/var/lib/nginx/tmp/fastcgi).each do |folder|
	directory folder do 
		owner node[:nginx][:user]
		group node[:nginx][:group]
		recursive true
		mode '755'
	end
end

