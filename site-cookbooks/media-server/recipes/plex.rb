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

docker_image 'plex' do
  source "/data/configs/chef/dockerfiles/plex"
  action :build_if_missing
end

docker_container 'plex' do
  repo 'plex'
  memory '4096M'
  network_mode 'host'
  env [ 'PLEX_MEDIA_SERVER_USER=nobody' ]
  volumes [
            '/data/configs/plex:/config',
            '/data/shares/Media:/media',
            '/dev/rtc:/dev/rtc:ro',
            '/etc/localtime:/etc/localtime:ro',
            '/tmp:/tmp'
          ]
  devices [
            {
              "PathOnHost"=>"/dev/dri",
              "PathInContainer"=>"/dev/dri",
              "CgroupPermissions"=>"mrw"
            }
          ]
  privileged true
  restart_policy 'always'
end
