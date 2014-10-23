#
# Cookbook Name:: sickbeard
# Recipe:: default
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

include_recipe "python"

package 'python-cheetah'

user "deploy" do
  supports :manage_home => true
  comment "Application User"
  uid 1000
  gid "nogroup"
  home "/home/deploy"
  shell "/bin/bash"
end

service "sickbeard" do
  supports :restart => true, :start => true
  action :nothing
end

directory "/var/run/sickbeard" do
  user "deploy"
  group "nogroup"
  action :create
end

cookbook_file "/etc/default/sickbeard" do
  source "sickbeard.options"
end

git "/home/deploy/sickbeard" do
  user "deploy"
  group "nogroup"
  repository "https://github.com/midgetspy/Sick-Beard.git"
  revision "master"
  action :sync
  notifies :restart, "service[sickbeard]", :delayed
end

link "/etc/init.d/sickbeard" do
  to "/home/deploy/sickbeard/init.ubuntu"
end

cookbook_file "/home/deploy/sickbeard/autoProcessTV/autoProcessTV.cfg" do
  user "deploy"
  group "nogroup"
end

service "sickbeard" do
  action :start
end

