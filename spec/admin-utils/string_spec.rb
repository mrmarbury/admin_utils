require 'rspec'
require 'admin-utils/string'

describe "Is Number Test" do

  it "should tell the an integer disguised as a string can be parsed to an integer" do
    "45".is_number?.should == true
  end

  it "should tell that a string with letters and numbers is not an integer" do
    "skd93l".is_number?.should == false
  end

  it "should tell that a string with just letters is not an integer" do
    "though shall not pass".is_number?.should == false
  end

  it "should tell that a string containing a float is not an integer" do
    "23.42".is_number?.should == false
  end

end