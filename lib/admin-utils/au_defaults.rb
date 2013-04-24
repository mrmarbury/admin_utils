module AuDefaults

  LOGGER_BASE = '/var/log'

  DEFAULT_INIT_SCRIPT_PATH = '/etc/init.d'

  # Retrieves the default config path that holds the yml files for the current application.
  # The +path+ variable can be used to override the default config path. The method can then be called
  # without argument to retrieve the currently set config path.
  #
  # NOTE: As a default this method returns an array.
  #
  def config_path(path = nil)
    AuDefaults.config_path(path)
  end

  class << self

    CONFIG_PATH = [ENV['HOME'] + '/.config', '/etc']

    def config_path(path = nil)
      @path_for_the_config = path || (@path_for_the_config || CONFIG_PATH)
    end

    # Call this to reset the config path to the default values of the +CONFIG_PATH+ array
    def reset_config_path
      @path_for_the_config = nil
    end
  end
end