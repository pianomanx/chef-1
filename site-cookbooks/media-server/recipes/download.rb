#
# Cookbook Name:: media-server
# Recipe:: download
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

docker_service 'default' do
  ipv6 false
  ipv6_forward false
  action [:create, :start]
end

include_recipe 'nfs'

directory '/data'

mount '/data' do
  device 'monolith.robotozon.com:/data'
  fstype 'nfs'
  options 'rw'
  action [:mount, :enable]
end

directory '/etc/systemd/system/docker.service.wants'

link '/etc/systemd/system/docker.service.wants/remote-fs.target' do
  to '/lib/systemd/system/remote-fs.target'
end

include_recipe 'media-server::couchpotato'
include_recipe 'media-server::sabnzbd'
include_recipe 'media-server::sonarr'
include_recipe 'media-server::transmission'
