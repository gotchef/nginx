
include_recipe 'runit'

include_recipe 'nginx::common_config'

runit_service 'nginx' do
	default_logger true
	sv_timeout 180
    action [:enable, :start]
end

