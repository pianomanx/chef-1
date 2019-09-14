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

package 'avahi-daemon'

service 'avahi-daemon' do
  action :start
end

cookbook_file '/etc/avahi/services/timemachine.service' do
  notifies :restart, 'service[avahi-daemon]', :delayed
end

docker_image 'samba' do
  source '/data/configs/chef/dockerfiles/samba'
  action :build_if_missing
end

docker_container 'samba' do
  repo 'samba'
  memory '512M'
  network_mode 'host'
  volumes [
            '/data/shares:/shares',
            '/data/configs/samba/smb.conf:/etc/samba/smb.conf'
          ]
  restart_policy 'always'
end
