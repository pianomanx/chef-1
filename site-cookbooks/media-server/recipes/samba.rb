#
# Cookbook Name:: media-server
# Recipe:: samba
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

name = 'samba'
repo = "skingry/#{name}"

include_recipe 'directories'

docker_image "#{name}" do
  repo "#{repo}"
  action :pull
end

docker_container "#{name}" do
  repo "#{repo}"
  memory '2147483648'
  memory_swap '4294967296'
  network_mode 'host'
  volumes [ '/data:/data', '/data/configs/samba/smb.conf:/etc/samba/smb.conf' ]
  restart_policy 'always'
end

