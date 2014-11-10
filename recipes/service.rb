
include_recipe 'runit'

runit_service 'nginx' do
	default_logger true
	options({
		
	})
    action [:enable, :start]
end

