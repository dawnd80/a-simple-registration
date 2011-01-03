require 'spec_helper'

describe User do
  
  it "should create a new instance given valid attributes" do
    valid_attr = Factory.attributes_for(:user)
    User.create!(valid_attr)
    User.count.should == 1
  end
  
  it "should return correct name" do
    user = Factory(:user, :first_name => "John", :last_name => "Doe")
    user.full_name.should == "John Doe"
  end

end
