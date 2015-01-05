include_recipe 'runit'

runit_service 'nginx' do
	default_logger true
	sv_timeout 180
	options({
		
	})
    action [:restart]
end

