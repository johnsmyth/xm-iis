#
# Cookbook Name:: xm-iis
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'iis::default'
include_recipe 'iis::mod_aspnet45'
include_recipe 'iis::mod_management'

iis_site 'Default Web Site' do
  action [:stop, :delete]
end

directory "#{node['iis']['docroot']}\\xm"

iis_site 'XM' do
  protocol :http
  port 80
  path "#{node['iis']['docroot']}\\xm"
  action [:add, :start]
end

template "#{node['iis']['docroot']}\\xm\\index.htm" do
  source 'index.erb'
  variables :buzzwords => %w(DevOps Chef Azure Velocity Microsoft Speed Monitoring Culture Collaboration BigData Magic Automagic Science CI CD)
end
