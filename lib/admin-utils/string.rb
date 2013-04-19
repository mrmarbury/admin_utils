class String

  # Custom String method to check if a string can be parsed to a number (Integer)
  #
  # This method is called directly on a String object
  #
  # Returns:
  # * +true+ String can be parsed to an Integer
  # * +false+ String can not be parsed to an Integer
  #
  # Example:
  #
  #     require 'admin-utils/string'
  #     .
  #     .
  #     .
  #     puts "is a number" if "12345".is_number?
  #
  def is_number?
    Integer(self)
    true
  rescue
    false
  end
end