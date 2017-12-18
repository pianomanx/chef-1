#
# Cookbook Name:: media-server
# Recipe:: transmission
#
# Copyright 2014, Seth Kingry
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

domain = node[:media_server][:domain]
name = 'transmission'
host = "#{name}"
port = '9091'
repo = "skingry/#{name}"

include_recipe 'directories'

directory "/data/configs/#{name}" do
  owner 'nobody'
  group 'nogroup'
end

docker_image "#{name}" do
  repo "#{repo}"
  action :pull
end

docker_container "#{name}" do
  repo "#{repo}"
  memory '1073741824'
  memory_swap '2147483648'
  network_mode 'container:openvpn'
  env [ 'PUID=65534', 'PGID=65534' ]
  volumes [ '/data:/data', '/etc/localtime:/etc/localtime:ro' ]
  restart_policy 'always'
end

template "/data/configs/nginx/sites/#{name}.conf" do
  source 'proxy_site.erb'
  variables :domain => "#{domain}",
            :host => "#{host}",
            :name => "#{name}",
            :port => "#{port}",
            :auth => true
end

