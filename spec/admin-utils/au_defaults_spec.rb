require 'rspec'
require 'admin-utils/au_defaults'

describe "Defaults" do
                                                                           
  before(:each) do
    AuDefaults.reset_config_path
  end

  it "should have a couple of default variables with the apropriate values" do
    AuDefaults::LOGGER_BASE.should == '/var/log'
  end

  it "should return the default config path when called for the first time" do
    AuDefaults.config_path.should == [ENV['HOME'] + '/.config', '/etc']
  end

  it "should return the the path, when given as argument" do
    AuDefaults.config_path('test').should == 'test'
  end

  it "should always return the same path once initialized with it" do
    AuDefaults.config_path('test').should == 'test'
    AuDefaults.config_path.should == 'test'
  end

  it "should return the new path, when reinitialized" do
    AuDefaults.config_path('test').should == 'test'
    AuDefaults.config_path('reinit').should == 'reinit'
    AuDefaults.config_path.should == 'reinit'
  end

  it "should return the default again, when reset" do
    AuDefaults.config_path('test').should == 'test'
    AuDefaults.config_path.should == 'test'
    AuDefaults.reset_config_path
    AuDefaults.config_path.should == [ENV['HOME'] + '/.config', '/etc']
  end

end