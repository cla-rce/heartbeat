#
# Cookbook Name:: heartbeat
# Recipe:: default
#
# Copyright 2009-2015, Chef Software, Inc.
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

raise "Cookbook 'heartbeat' requires Chef >= 12.1." if node['chef_packages']['chef']['version'].to_f < 12.1

case node['platform_family']
when 'rhel', 'fedora'
  package_list = ['heartbeat', 'heartbeat-devel']
when 'debian'
  package_list = ['heartbeat', 'heartbeat-dev']
end

# Must install all packages simultaneously on v5 RHEL-based OSes, otherwise
# we get an installation conflict between heartbeat-pils (depended on by
# hearbeat) and heartbeat-devel. Requires the multi-package installation syntax
# introduced in Chef 12.1.
package package_list

service 'heartbeat' do
  supports(
    restart: true,
    status: true
  )
  action :enable
end
