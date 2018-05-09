require 'ostruct' unless defined? OpenStruct

module AuUtil

  def AuUtil.hash_to_ostruct(object)
    return case object
    when Hash
      object = object.clone
      object.each do |key, value|
      object[key] = hash_to_ostruct(value)
    end
    OpenStruct.new(object)
    when Array
      object = object.clone
      object.map! { |i| hash_to_ostruct(i) }
    else
      object
    end
  end

  # Basicaly this method can unzip any gzipped file
  #
  # Params:
  # * +archive_name+ Filename (including path) of the dump file to extract
  # * +extract_dir+ The directory the dump should be extracted to. If left +nil+, the dir name of the +dump_archive_name+ is used. Otherwise it is just set
  #   to "."
  #
  # Raises:
  # * +File::IOError+ In case there was an error during extraction
  #
  def extract_gzip(archive_name, extract_dir = (File.dirname(archive_name) or '.'))
    raise ArgumentError, "File #{archive_name} does not exist!" unless File.exists? archive_name
    logger.info "Extracting \"#{archive_name}\" to directory \"#{extract_dir}\""
    Open3.popen3 "gunzip -c #{archive_name} > " + extract_dir + "/" + File.basename(archive_name).chomp('.gz') do |stdin, stdout, stderr, t|
      unless t.value.to_s.include? "exit 0"
        raise File::IOError, "gzipped file #{archive_name} could not be extracted!\nThe error message was: #{stderr.read}"
      end
    end
  end

  # Executes Unix which and checks, if a binary is in path. Only works on Unix alike systems
  #
  # Params:
  # * +name+ Command to check for
  #
  # Returns:
  # * +true+ - Command in path
  # * +false+ - Command not in path
  #
  def self.command?(name)
    `which #{name}`
    $?.success?
  end
end
