require 'spec_helper'

describe 'xm-iis::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  describe windows_feature('IIS-Webserver') do
    it {should be_installed.by('dism')}
  end

  describe service('w3svc') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end

  describe port(80) do
    it { should be_listening }
  end

  describe iis_website('Default Website') do
    it { should_not exist }
  end

  describe iis_website('XM') do
    it { should exist }
  end

  describe file('C:/inetpub/wwwroot/xm/index.htm') do
    it {should be_file}
  end
end
