#
# Cookbook Name:: plexpy
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

package 'python-cheetah'
package 'python-lxml'
package 'python-openssl'

directory '/config' do
  owner 'nobody'
  group 'nogroup'
end

directory '/logs' do
  owner 'nobody'
  group 'nogroup'
end

git '/plexpy' do
  repository 'https://github.com/drzoidberg33/plexpy.git'
  enable_checkout false
  checkout_branch 'master'
  action :sync
end

cookbook_file '/sbin/plexpy' do
  mode 0755
end

