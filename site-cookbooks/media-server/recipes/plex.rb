#
# Cookbook Name:: media-server
# Recipe:: plex
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
name = 'plex'
host = "#{name}"
port = '32400'
repo = "skingry/#{name}"

include_recipe 'directories'

directory "/data/configs/#{name}" do
  owner 'nobody'
  group 'nogroup'
end

directory "/data/configs/#{name}/Library" do
  owner 'nobody'
  group 'nogroup'
  recursive true
  notifies :restart, "docker_container[#{name}]", :delayed
end

directory "/data/configs/#{name}/Library/Application Support" do
  owner 'nobody'
  group 'nogroup'
  recursive true
  notifies :restart, "docker_container[#{name}]", :delayed
end

docker_image "#{name}" do
  repo "#{repo}"
  action :pull
  notifies :redeploy, "docker_container[#{name}]"
end

docker_container "#{name}" do
  repo "#{repo}"
  memory '8589934592'
  memory_swap '17179869184'
  port '32400:32400'
  volumes [ '/data:/data' ]
  restart_policy 'always'
end

template "/data/configs/nginx/sites/#{name}.conf" do
  source 'plex_proxy_site.erb'
  variables :domain => "#{domain}",
            :host => "#{host}",
            :name => "#{name}",
            :port => "#{port}"
end

