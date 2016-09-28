#
# Cookbook Name:: media-server
# Recipe:: certbot
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

git "/opt/certbot" do
  repository "https://github.com/certbot/certbot"
  revision "master"
  action :sync
end

cron "certbot Certificate Renewal" do
  minute "0"
  hour "3"
  weekday "1"
  mailto "sjkingry@gmail.com"
  path "/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin"
  command "/opt/certbot/certbot-auto --config-dir /data/configs/nginx/ssl renew && docker restart nginx"
end

