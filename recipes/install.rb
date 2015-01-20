#
# Cookbook Name:: nginx

#dependencies
include_recipe 'build-essential'

#nginx custom module
include_recipe "nginx::ngx_txid"

include_recipe 'nginx::common_dirs'

group node[:nginx][:group] do
end

# setup user
user node[:nginx][:user] do
	comment "Created by chef"
	gid node[:nginx][:group] 
	home "/home/nginx"
	shell "/bin/false"
	supports :manage_home => false
	system true
end

#dependencies
packages = value_for_platform_family(
  %w(rhel fedora) => %w(pcre-devel openssl-devel httpd-devel zlib zlib-devel GeoIP GeoIP-devel gd-progs gd-devel),
  %w(default)     => %w(libpcre3 libpcre3-dev libssl-dev)
)

packages.each do |name|
  package name
end

archive_dir = Chef::Config[:file_cache_path]
tarball = "nginx-#{node[:nginx][:version]}.tar.gz"
tarball_path  = "#{archive_dir}/#{tarball}"
extract_path = "#{archive_dir}/nginx-#{node[:nginx][:version]}"

remote_file tarball_path do
  source   node[:nginx][:source][:url] 
  checksum node[:nginx][:source][:checksum]
  mode		"775"
  backup   false
end

execute "extract #{tarball}" do
  cwd archive_dir
  command "tar zxvf #{tarball}"
  #not_if {File.exists?(extract_path) or (target and File.exists?(target))}
end

# Configure, Build & Install
configure_flags = node[:nginx][:source][:default_configure_flags] | node[:nginx][:source][:configure_flags]
configure_options = configure_flags.join(' ')

log configure_options

execute "configure #{tarball}" do
   cwd extract_path
   command "./configure #{configure_options}"
#   not_if {File.exists?("#{extract_path}/Makefile") or (target and File.exists?(target))}
end

execute "make #{tarball}" do
   cwd extract_path
   command "make"
#   not_if {(target and File.exists?(target))}
end

execute "make install #{tarball}" do
  cwd extract_path
  command "make install"
  user "root"
  group "root"
#  not_if {(target and File.exists?(target))}
  notifies :restart, 'runit_service[nginx]'
end

execute 'openssl dhparam -out dhparam.pem 4096' do
	cwd '/etc/ssl/certs'
	not_if { ::File.exists?("/etc/ssl/certs/dhparam.pem")}
end

include_recipe 'nginx::common_config'
