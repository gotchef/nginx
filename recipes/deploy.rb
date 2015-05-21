# config
#
#
::Chef::Recipe.send(:include, AwsUtil::Layer)

include_recipe "aws-util::opsworks_hosts"

node[:deploy].each do |app_name, deploy|
	# only do this check for opsworks
	if !node[:opsworks].nil? and !node[:me][:layers].include? deploy[:document_root].downcase
		Chef::Log.info("skipping deployment of site #{app_name}. opsworks application document root must be in the following layers #{node[:me][:layers].join(", ")}")
		next
	end

	Chef::Log.info("deploying nginx site #{app_name}")

	tmp = deploy[:environment_variables]['layers']
	layers = (tmp.nil? or tmp.empty?) ? [] : tmp.split(",")
	hosts = layers_ips(layers)

	Chef::Log.debug("deploy application #{app_name} with layers #{tmp} ")

	configure_site do
		site_domain       deploy[:domains][0]
		template_cookbook node[:nginx][:template][:deploy_cookbook]
		hosts 			  hosts	
		ssh_cert          deploy['ssl_certificate']
		ssh_key           deploy['ssl_certificate_key']
	end
end
