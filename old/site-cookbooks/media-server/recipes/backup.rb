#
# Cookbook Name:: media-server
# Recipe:: backup
#
# Copyright 2016, Seth Kingry
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

docker_image 'base' do
  source '/opt/config/chef/dockerfiles/base'
  action :build_if_missing
end

cron 'Config Backup' do
  minute '0'
  hour '4'
  day '1'
  command "docker run --rm -v '/data:/data' -v '/opt/config/backup/backup.sh:/usr/sbin/backup' base backup > /var/log/backup.log"
end
