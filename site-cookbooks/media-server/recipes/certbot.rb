#
# Cookbook Name:: media-server
# Recipe:: certbot
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

docker_image 'certbot' do
  source '/data/configs/dockerfiles/certbot'
  action :build_if_missing
end

docker_container 'certbot' do
  repo 'certbot'
  memory '256M'
  network_mode 'host'
  volumes [ '/data/configs/nginx/ssl:/config', '/data/configs/nginx/webroot:/webroot' ]
  action :create
end

cron 'Certbot Certificate Renewal' do
  minute '0'
  hour '3'
  weekday '1'
  mailto "#{node[:cron_mailto]}"
  command 'docker start certbot  2>&1 >> /dev/null && docker restart nginx 2>&1 >> /dev/null'
end
