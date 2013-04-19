require 'rspec'
require 'construct'
require 'construct/helpers'

require 'admin-utils/au_logger'
require 'admin-utils/au_config'
require 'admin-utils/au_defaults'
require 'admin-utils/au_util'

include Construct::Helpers
include AuLogger
include AuConfig

describe "Loading Config Files" do

  it "should load a config file from a single path" do

    config_dir = "config/dir"

    within_construct do |const|
      const.directory config_dir do |dir|
        dir.file('config.yml', 'rabbit_hole: kinky_fudge')
      end

      config = load_config('config.yml', config_dir)
      config.rabbit_hole.should == 'kinky_fudge'
    end
  end

  it "should load a config file when an array of paths is given" do
    config_dir_one = 'config/dir/one'
    config_dir_two = 'config/dir/two'
    conf_dirs = [config_dir_two, config_dir_one]

    within_construct do |const|
      const.directory config_dir_one do |dir|
        dir.file('config.yml', 'fiasco_drive: ladyada')
      end
      const.directory config_dir_two

      config = load_config('config.yml', conf_dirs)
      config.fiasco_drive.should == 'ladyada'
    end
  end

  it "should load a the first found config file when an array of paths is given" do
    config_dir_one = 'config/dir/one'
    config_dir_two = 'config/dir/two'
    conf_dirs = [config_dir_two, config_dir_one]

    within_construct do |const|
      const.directory config_dir_one do |dir|
        dir.file('config.yml', 'fiasco_drive: ladyada')
      end
      const.directory config_dir_two do |dir|
        dir.file('config.yml', 'fiasco_drive: bagel_and_a_smeer')
      end

      config = load_config('config.yml', conf_dirs)
      config.fiasco_drive.should == 'bagel_and_a_smeer'
    end
  end
end