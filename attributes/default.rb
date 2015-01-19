version = "1.7.6"
default[:nginx][:version] = version
default[:nginx][:source][:url]      = "http://nginx.org/download/nginx-#{version}.tar.gz"
default[:nginx][:source][:checksum] = '08e2efc169c9f9d511ce53ea16f17d8478ab9b0f7a653f212c03c61c52101599'
default[:nginx][:user]  = 'nginx'
default[:nginx][:group] = 'nginx'
default[:nginx][:conf_dir] = '/etc/nginx'
default[:nginx][:log_dir]  = '/var/log/nginx'
default[:nginx][:pid]      = '/var/run/nginx.pid'
default[:nginx][:sbin]     = "/usr/local/sbin/nginx" 

txid_module_path = "#{Chef::Config['file_cache_path']}/ngx_txid"

default[:nginx][:source][:configure_flags] = %W(
  --with-http_image_filter_module
  --with-http_addition_module
  --with-http_ssl_module
  --with-http_gzip_static_module
  --with-http_stub_status_module
  --with-http_geoip_module
  --add-module=#{txid_module_path}
)

default[:nginx][:source][:default_configure_flags] = %W(
  --user=#{node[:nginx][:user]}
  --group=#{node[:nginx][:group]}
  --prefix=/usr/local/nginx 
  --sbin-path=#{node[:nginx][:sbin]}
  --conf-path=#{node[:nginx][:conf_dir]}/nginx.conf
  --error-log-path=#{node[:nginx][:log_dir]}/error.log 
  --http-log-path=#{node[:nginx][:log_dir]}/access.log 
  --http-client-body-temp-path=/var/lib/nginx/tmp/client_body 
  --http-proxy-temp-path=/var/lib/nginx/tmp/proxy 
  --http-fastcgi-temp-path=/var/lib/nginx/tmp/fastcgi 
  --lock-path=/var/lock/subsys/nginx 
  --pid-path=#{node[:nginx][:pid]} 
)

# used to determine what nginx configs to deploy 
# set using aws-util::opsworks_hosts
default[:me][:layers] = ['nginx']
#default template cookbook source
default[:nginx][:template][:deploy_cookbook] = 'nginx' 
