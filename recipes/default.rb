#
# Cookbook Name:: s3cmd
# Recipe:: default
#

#install s3cmd
package_path = ::File.join(node[:s3cmd][:download_to], "s3cmd-1.1.0-beta2.tar.gz")

remote_file package_path do
  source "http://sourceforge.net/projects/s3tools/files/s3cmd/1.1.0-beta2/s3cmd-1.1.0-beta2.tar.gz"
  action :create_if_missing
end

bash 's3cmd' do
  cwd node[:s3cmd][:download_to]
  code <<-EOH
  tar xzf s3cmd-1.1.0-beta2.tar.gz
  cp -r s3cmd-1.1.0-beta2/S3 s3cmd-1.1.0-beta2/s3cmd /usr/bin/
  EOH
  action :nothing
  subscribes :run, resources(:remote_file => package_path), :immediately
end

#deploy configuration for each user. Change s3cfg.erb template in your site cookbook to set
#you access key and secret.
node[:s3cmd][:users].each do |user|

  home = user == :root ? "/root" : "/home/#{user}"

  template "s3cfg" do
      path "#{home}/.s3cfg"
      source "s3cfg.erb"
      mode 0655
  end
end
