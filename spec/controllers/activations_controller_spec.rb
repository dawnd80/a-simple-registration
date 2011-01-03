require 'spec_helper'

describe ActivationsController do

  describe "show new activation form" do
    before(:each) do
      get :new
    end
    
    it "should be success" do
      response.should be_success
    end
    
    it "should render the new form" do
      response.should render_template("new")
    end
  end
  
  describe "create activation record and email" do
    it "should create successfully and send an email" do
      @activation = Factory.attributes_for(:activation)
      UserMailer.should_receive(:deliver_registration_confirmation)

      post :create, :activation => @activation

      assigns[:activation].should_not be_new_record
      response.should render_template("create")
    end

    it "should re-render new template if passing in an existing email address" do
      Factory(:activation, :email => "user@example.com")
      @activation = Factory.attributes_for(:activation, :email => "user@example.com")

      post :create, :activation => @activation

      assigns[:activation].should be_new_record
      response.should render_template("new")
    end
  end

end
