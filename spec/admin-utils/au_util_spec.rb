require 'rspec'
require 'admin-utils/au_util'

describe "Create OpenStruct from Hash" do

  it "should convert a Hash to an OpenStruct" do
    my_hash = { key1: "value", key2: "otherValue" }
    my_ostruct = AuUtil.hash_to_ostruct my_hash

    my_ostruct.key1.should == "value"
    my_ostruct.key2.should == "otherValue"
  end

  it "should treat an array just like an array" do
    my_array = %w[ word1 word2 ]
    my_ostruct = AuUtil.hash_to_ostruct my_array
    my_ostruct[0].should == "word1"
    my_ostruct[1].should == "word2"
  end
end