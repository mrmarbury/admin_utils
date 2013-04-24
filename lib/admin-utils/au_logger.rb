require 'log4r' unless defined? Log4r

module AuLogger

  # Retrieves the current logger instance or initializes a new one.
  #
  # For parameters to use during initialization, see +AuLogger.initialize_logger+
  #
  # Default Usage Example:
  #
  #     logger.info "my info text"
  #
  #
  def logger(hash={})
    AuLogger.logger(hash)
  end

  class << self

    PATTERN="%d -= %l =- : %m"
    UNINITIALIZED_NAME='UNINITIALIZED'

    def logger(hash={})
      @logger ||= initialize_logger(hash)
    end

    # Used to initialize the logging system.
    #
    # Params:
    # * +hash+ The hash containing all config varables
    #
    # The possible +hash+ variables are as follows:
    # * :mode => The logging mode to use. See below. If unset, command line only logging will be used
    # * :filename => Path to the logfile that should be written
    # * :name => The name the logger will have (See +Log4r+ documentation on this!). Default is 'UNINITIALIZED_NAME'
    # * :level => The log level according to +Log4r::<LEVEL>+ (See +Log4r+ documentation on this!). Set to INFO by default
    # * :additive => Is the logger additive (See +Log4r+ documentation on this!)
    # * :trace => Record trace information (See +Log4r+ documentation on this!)
    #
    # Example:
    #
    #     AuLogger.initialize_logger(
    #       name: 'my_logger',
    #       filename: '/var/log/my_logger.log'
    #     )
    #
    # Current Modes:
    # * +cronjob+ Log everything to a log file but messages with level WARN and above to stdout as well so they will be included in the crond status email
    # * +daemon+ Log to a log file only
    # * +dual+ Log everything to log file and to the console
    #
    def initialize_logger(hash={})
      Log4r.define_levels(*Log4r::Log4rConfig::LogLevels)
      @mode = (hash[:mode] or '')
      @filename = (hash[:filename] or nil)
      @ncurses_window = (hash[:ncurses_window] or nil)
      @logger = Log4r::Logger.new(
        (hash[:name] or UNINITIALIZED_NAME),
        (hash[:level] or Log4r::INFO),
        (hash[:additive]),
        (hash[:trace])
      )

      log_pattern = Log4r::PatternFormatter.new(pattern: (hash[:pattern] or PATTERN))

      if @mode == 'cronjob'
        raise ArgumentError, 'Path to a log file must be added in cronjob mode!' unless @filename
        @logger.outputters = Log4r::StdoutOutputter.new('cronjob stdout', level: WARN, formatter: log_pattern)
        @logger.add Log4r::FileOutputter.new('log', filename: @filename, formatter: log_pattern)
        @logger.debug 'Logger initialized in cronjob mode'
      elsif @mode == 'daemon'
        raise ArgumentError, 'Path to a log file needed in daemon mode!' unless @filename
        @logger.outputters = Log4r::FileOutputter.new('daemon log', filename: @filename, formatter: log_pattern)
        @logger.debug 'Logger initialized in daemon mode'
      elsif @mode == 'dual'
        raise ArgumentError, 'Path to a log file needed in dual mode!' unless @filename
        @logger.outputters = Log4r::StdoutOutputter.new('dual stdout', formatter: log_pattern)
        @logger.add Log4r::FileOutputter.new('log', filename: @filename, formatter: log_pattern)
        @logger.debug 'Logger initialized in dual mode. Log output will be logged to Console and Logfile'
      else
        @logger.outputters = Log4r::StdoutOutputter.new('stdout', formatter: log_pattern)
        @logger.debug 'Logger initialized for stdout only mode'
      end
      if logger.name == UNINITIALIZED_NAME
        logger.debug 'Logger uses the default name at the moment'
      end
      @logger
    end
  end
end
