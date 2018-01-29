#
# Cookbook Name:: media-server
# Recipe:: nginx
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
name = 'nginx'


docker_container "#{name}" do
  repo "#{name}"
  memory '536870912'
  links [ 'openvpn:couchpotato', 'openvpn:sabnzbd', 'openvpn:sonarr', 'openvpn:transmission', 'grafana:grafana', 'plexpy:plexpy', 'resilio:resilio' ]
  port [ '80:80', '443:443' ]
  volumes [ '/data/configs/nginx:/config' ]
  restart_policy 'always'
end

