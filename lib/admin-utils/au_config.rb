require 'yaml' unless defined? YAML
require 'admin-utils/au_defaults' unless defined? AuDefaults
require 'admin-utils/au_util' unless defined? AuUtil

module AuConfig

  # Method that loads a yml file and return an object of type +OpenStruct+
  #
  # Params:
  # * +config_file+ Name of the config file to load
  # * +override_path+ Path to the directory that contains the yml file. If left blank, the default is taken which is configured in
  #   +AuDefaults+'s +CONFIG_PATH+ array. Can be either an array of path names or a single path as a string
  #
  # If +override_path+ is an array (e.g. when using the default), the first occurrence of the config file ist loaded.
  def load_config(config_file, override_path = nil)
    raise ArgumentError 'Plain config file name needed as string!' unless config_file
    @config_path = AuDefaults.config_path override_path
    begin
      @configuration = get_config_file_for_path(@config_path, config_file)
      logger.debug 'Using Config File: ' + @configuration.path
      @yml_data = YAML.load @configuration
      AuUtil.hash_to_ostruct @yml_data
    rescue => error
      logger.error "Error opening file #{@configuration}. The Message was: #{error.message}\n#{error.backtrace.join("\n")}"
      raise
    end
  end

  ########
  private
  ########

  def get_config_file_for_path(cfg_path, config_file)
    if cfg_path.respond_to? "each"
      cfg_path.each do |path|
        return File.new(File.join(path, config_file)) if File.exists? path + "/" + config_file
      end
      raise IOError, "FIle #{config_file} not found in path: #{cfg_path}"
    else
      File.new(File.join(cfg_path, config_file))
    end
  end
end
