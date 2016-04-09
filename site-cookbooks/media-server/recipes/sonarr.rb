#
# Cookbook Name:: media-server
# Recipe:: sonarr
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

docker_image 'sonarr' do
  repo 'tuxeh/sonarr'
  action :pull
  notifies :redeploy, 'docker_container[sonarr]'
end

docker_container 'sonarr' do
  repo 'tuxeh/sonarr'
  port '8989:8989'
  host_name 'sonarr'
  user 'nobody'
  volumes [ '/data/configs:/volumes/config', '/data:/data' ]
end

