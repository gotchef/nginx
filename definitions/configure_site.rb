
define :configure_site do
	site_domain = params[:site_domain] # api.woah.com
	template_cookbook = params[:template_cookbook]
	ssh_cert = params[:ssh_cert] # chained cert
	ssh_key = params[:ssh_key] # private key
	hosts = params[:hosts]

	runit_service "nginx" do
		supports :restart => true, :status => true 
		action :nothing # only define so that it can be restarted if the config changed
	end

	template "#{node[:nginx][:conf_dir]}/sites-enabled/#{site_domain}" do
		cookbook	"#{template_cookbook}"
		source		"#{site_domain}.erb"
		owner		node[:nginx][:user]
		group		node[:nginx][:group]
		mode		"644"
		variables(
			:hosts => hosts
		)
		notifies :restart, "runit_service[nginx]"
	end

	directory "/var/log/nginx/#{site_domain}" do
		mode      '0755'
		owner     node[:nginx][:user]
		group     node[:nginx][:group]
		action    :create
		recursive true
	end

	if !ssh_cert.to_s.empty?
		file File.join('/etc/pki/tls/certs/', "#{site_domain}.chained.crt") do
			mode    '0755'
			owner   node[:nginx][:user]
			group   node[:nginx][:group]
			content ssh_cert
		end

		file File.join('/etc/pki/tls/private/', "#{site_domain}.ssl.key") do
			mode    '0640'
			owner   node[:nginx][:user]
			group   node[:nginx][:group]
			content ssh_key
		end
	end
end
