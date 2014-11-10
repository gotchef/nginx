src_filename = "ngx_txid.tar.gz"
src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}"

cookbook_file "#{src_filepath}" do
  source	"#{src_filename}"
  mode		'0644'
  owner		'root'
  group		'root'
end

execute "tar" do
  user		"root"
  group		"root"
  cwd		Chef::Config['file_cache_path']
  command "tar zxvf #{src_filepath}"
end

