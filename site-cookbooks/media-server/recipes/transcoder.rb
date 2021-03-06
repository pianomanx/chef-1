#
# Cookbook Name:: media-server
# Recipe:: transcoder
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

apt_repository 'jonathonf_ffmpeg-3' do
  uri 'ppa:jonathonf/ffmpeg-3'
end

apt_repository 'mkvtoolnix' do
  uri 'https://mkvtoolnix.download/ubuntu/xenial/'
  distribution '/'
  key 'https://mkvtoolnix.download/gpg-pub-moritzbunkus.txt'
  action :add
end

python_package 'ffmpeg-normalize'

package 'dvdauthor'
package 'genisoimage'
package 'growisofs'
package 'jq'
package 'sqlite3'
package 'ffmpeg'
package 'mkvtoolnix'

