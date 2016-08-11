#
# Cookbook Name:: docker-couchpotato
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

include_recipe 'python'

package 'p7zip-full'
package 'par2'
package 'python-cheetah'
package 'python-lxml'
package 'python-openssl'
package 'python-yenc'
package 'unzip'

remote_file '/tmp/unrar.deb' do
  source 'http://launchpadlibrarian.net/214085480/unrar_5.3.2-1_amd64.deb'
end

bash 'Install Unrar (non-free)' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  dpkg -i /tmp/unrar.deb
  rm -rf /tmp/unrar.deb
  EOH
end

git '/sabnzbd' do
  repository 'https://github.com/sabnzbd/sabnzbd.git'
  enable_checkout false
  checkout_branch 'master'
  action :sync
end

directory '/config' do
  owner 'nobody'
  group 'nogroup'
end

cookbook_file '/sbin/my_init' do
  mode 0755
end

