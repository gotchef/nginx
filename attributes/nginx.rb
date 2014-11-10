default[:nginx][:error_log_options] = "warn"

default['nginx']['gzip']              = 'on'
default['nginx']['gzip_static']       = 'off'
default['nginx']['gzip_http_version'] = '1.0'
default['nginx']['gzip_comp_level']   = '2'
default['nginx']['gzip_proxied']      = 'any'
default['nginx']['gzip_vary']         = 'off'
default['nginx']['gzip_buffers']      = nil
default['nginx']['gzip_types'] = %w(
  text/plain
  text/css
  application/x-javascript
  text/xml
  application/xml
  application/rss+xml
  application/atom+xml
  text/javascript
  application/javascript
  application/json
  text/mathml
)
default['nginx']['gzip_min_length']   = 1_000
default['nginx']['gzip_disable']      = 'MSIE [1-6]\.'

default['nginx']['keepalive']            = 'on'
default['nginx']['keepalive_timeout']    = 65
default['nginx']['worker_processes']     = node['cpu'] && node['cpu']['total'] ? node['cpu']['total'] : 1
default['nginx']['worker_connections']   = 1_024
default['nginx']['worker_rlimit_nofile'] = nil
default['nginx']['multi_accept']         = false
default['nginx']['event']                = nil
default['nginx']['server_tokens']        = nil
default['nginx']['server_names_hash_bucket_size'] = 64
default['nginx']['sendfile'] = 'on'

default['nginx']['access_log_options']     = nil
default['nginx']['disable_access_log']     = false
default['nginx']['install_method']         = 'package'
default['nginx']['default_site_enabled']   = true
default['nginx']['types_hash_max_size']    = 2_048
default['nginx']['types_hash_bucket_size'] = 64

default['nginx']['proxy_read_timeout']      = nil
default['nginx']['client_body_buffer_size'] = nil
default['nginx']['client_max_body_size']    = nil
