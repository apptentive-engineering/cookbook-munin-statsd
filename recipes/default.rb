#
# Cookbook Name:: munin-statsd
# Recipe:: default
#
# Copyright (c) 2013, Apptentive, Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#
#     * Neither the name of the Apptentive, Inc. nor the
#       names of its contributors may be used to endorse or promote products
#       derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL Apptentive, Inc. BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#
#

include_recipe 'perl'

cpan_module 'Test::Simple' # required for Munin::Node::Client
cpan_module "Munin::Node::Client"

template "munin-statsd.pl" do
  path "/usr/local/bin/munin-statsd.pl"
  source "munin-statsd.pl.erb"
  owner "root"
  group "root"
  mode "0755"
  variables(
    statsd_host:    node[:statsd][:host],
    statsd_port:    node[:statsd][:port],
    use_tags:       node[:statsd][:use_tags]
  )
end

cron 'munin-statsd' do
  command '/usr/bin/timeout --kill-after 10s 30s /usr/local/bin/munin-statsd.pl 2>&1 > /dev/null'
  only_if { File.exist?("/usr/local/bin/munin-statsd.pl") }
end

