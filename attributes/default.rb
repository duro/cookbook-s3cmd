#list of users that will have the s3cmd configuration
default[:s3cmd][:users] = ["root"]
default[:s3cmd][:aws_access_key_id] = ""
default[:s3cmd][:aws_secret_access_key] = ""

default[:s3cmd][:download_to] = Chef::Config[:file_cache_path]
