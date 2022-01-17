#
# Cookbook Name:: media-server
# Recipe:: minecraft
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

docker_image 'itzg/minecraft-server' do
  action :pull
end

docker_container 'minecraft' do
  repo 'itzg/minecraft-server'
  memory '8192M'
  memory_swap '-1'
  network_mode 'host'
  env [
        'UID=65534',
        'GID=65534',
        'EULA=TRUE',
        'MEMORY=8G'
      ]
  volumes [
            '/data/configs/minecraft:/data'
          ]
  restart_policy 'always'
end
