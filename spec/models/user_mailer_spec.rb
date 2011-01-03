require 'spec_helper'

describe UserMailer do
  
  describe "when sending a registration email" do
    before(:each) do
      @activation = Factory(:activation, :email => "dxue@epocrates.com")
      @email = UserMailer.create_registration_confirmation(@activation)
    end

    it "should be from dixieepoc" do
      @email.from.should == ['dixieepoc@gmail.com']
    end
  
    it "should be send to the user's email address" do
      @email.to.should == [@activation.email]
    end
    
    it "should contain a subject" do
      @email.subject.should == "Please confirm your registration"
    end
    
    it "should contain the activation key" do
      @email.body.should =~ /key=#{@activation.unique_key}/
    end
  
  end

end