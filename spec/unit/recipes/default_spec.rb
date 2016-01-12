#
# Cookbook Name:: xm-iis
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'xm-iis::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

#Does the cookbook you're targeting have matchers for its LWRPs?
    it 'stop and delete default iis site' do
      expect(chef_run).to stop_iis_site('Default Web Site')
      expect(chef_run).to delete_iis_site('Default Web Site')
    end

    it 'creates new site and content' do
      expect(chef_run).to create_directory('C:\inetpub\wwwroot\xm')
      expect(chef_run).to add_iis_site('XM')
      expect(chef_run).to render_file('C:\inetpub\wwwroot\xm\index.htm').with_content('DevOps')
    end
  end
end
