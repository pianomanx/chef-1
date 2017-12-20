#
# Cookbook Name:: media-server
# Recipe:: grafana
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
name = 'grafana'
host = "#{name}"
port = '3000'
repo = "grafana/#{name}"

include_recipe 'directories'

directory "/data/configs/#{name}"

docker_image "#{name}" do
  repo "#{repo}"
  action :pull
  notifies :redeploy, "docker_container[#{name}]"
end

docker_container "#{name}" do
  repo "#{repo}"
  memory '1073741824'
  memory_swap '2147483648'
  links [ 'influxdb:influxdb.local' ]
  volumes [ '/data/configs/grafana/grafana.ini:/etc/grafana/grafana.ini', '/data/configs/grafana:/var/lib/grafana' ]
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

