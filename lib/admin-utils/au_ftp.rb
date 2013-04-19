require 'net/ftp' unless defined? Net::FTP
require 'open3' unless defined? Open3
require 'admin-utils/au_logger' unless defined? AuLogger

include AuLogger

module AuFtp

  # Transfers files to a remote ftp host
  #
  # Params:
  # * +ftp+ Valid object of type +Net::FTP+. The connection must be open
  # * +directory+ The remote directory the files are put to.
  # * +transfered_file+ A single file or an array of files that should be transfered
  #
  # Raises:
  # * +Net::FTPPermError+ if there is a FTP permission problem of any kind
  # * +Net::FTPError+ if anything goes wrong during FTP transfer
  # * +TypeError+ if any of the input variables have the wrong type (including being nil)
  #
  def transfer_via_ftp(ftp, directory, transfered_files)
    raise "\"ftp\" must be an object of type Net::FTP and the conenction must be open" unless ftp.is_a? Net::FTP
    begin
      entry_dir = ftp.pwd
      ftp.chdir directory
      if transfered_files.empty?
        logger.warn "No file(s) for ftp transfer to directory \"#{directory}\" given. Doing nothing ... "
      elsif transfered_files.respond_to?("each")
        transfered_files.each do |file|
          logger.info "Putting file \"#{file}\" to ftp server"
          ftp.putbinaryfile file
        end
      else
        logger.info "Putting single file \"#{transfered_files}\" to ftp server"
        ftp.putbinaryfile transfered_files
      end
      ftp.chdir entry_dir
    rescue Net::FTPPermError => ftpPerm
      logger.error "Permission problems encountered during ftp transfer. Message was: " +
        ftpPerm.message + "\n" + ftpPerm.backtrace.join("\n")
      close_ftp_connection ftp
      raise
    rescue TypeError => typeError
      logger.error "A type error occured. Make sure all variables contain the correct value types and are not nil! Message was: " +
        typeError.message + "\n" + typeError.backtrace.join("\n")
      close_ftp_connection ftp
      raise
    rescue Net::FTPError => ftpError
      logger.error "Error during ftp transfer. Message was:" +
        ftpError.message + "\n" + ftpError.backtrace.join("\n")
      close_ftp_connection ftp
      raise
    else
      logger.info "ftp transfer finished successfully"
    end
  end

  # Opens an FTP connection
  # Basically it is a convenience method that wraps the +Net::FTP+ methods
  # +connect+ and +login+. So the input variables match those needed by those two
  # methods.
  #
  # NOTE: +port+, +user+, +passwd+, +acct+ can be nil. +port+ will be set to 21 by default.
  #
  def open_ftp_connection(host, port=21, user=nil, passwd=nil, acct=nil)
    begin
      logger.info "Opening ftp connection"

      ftp = Net::FTP.new
      ftp.connect(host, port)
      ftp.login(user,passwd,acct)
    rescue Net::FTPPermError => ftp_perm
      logger.error "Permission problems encountered during ftp connect. Message was: " +
        ftp_perm.message + "\n" + ftp_perm.backtrace.join("\n")
      close_ftp_connection ftp
      raise
    rescue Net::FTPError => ftp_error
      logger.error "Error during ftp operation. Message was:" +
        ftp_error.message + "\n" + ftp_error.backtrace.join("\n")
      close_ftp_connection ftp
      raise
    rescue SocketError => socket_error
      logger.error "There was an error while accessing a socket. The Message was: " +
        socket_error.message + "\n" + socket_error.backtrace.join("\n")
      raise
    end
    ftp
  end

  # Closes the ftp conncetion given as parameter +ftp+ which must be a valid object of type +Net::FTP+
  #
  # NOTE: Does nothing, when +ftp+ is nil. Just logs a warning message in case a +Net::FTPConnectionError+ is catched.
  #
  def close_ftp_connection(ftp)
    raise "\"ftp\" must be an object of type Net::FTP" unless ftp.is_a? Net::FTP
    begin
      ftp.close unless ftp.nil?
    rescue Net::FTPConnectionError => conError
      logger.warn "There was an error when trying to close the ftp connection. The message was: #{conError.message}"
    else
      logger.info "Ftp connection closed"
    end
  end
end