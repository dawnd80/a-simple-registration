require 'spec_helper'

describe UsersController do

  describe "complete registration" do
    
    describe "show registration form" do
      before(:each) do
        @activation = Factory(:activation)
        get :new, {:key => @activation.unique_key}
      end
      
      it "should be successful" do
        response.should be_success
        response.should render_template("new")
        assigns[:user].should_not be_nil
      end
    end
    
    describe "create user with valid params" do
      before(:each) do
        @user = Factory.attributes_for(:user)
        post :create, {:user => @user}
      end
      
      it "should be successful" do
        assigns[:user].should_not be_new_record
        response.should redirect_to(edit_user_url(assigns[:user].id, :registering => true))
      end
    end
    
    describe "create user with invalid params" do
      before(:each) do
        @user = Factory.attributes_for(:user, :password => "123")
        post :create, {:user => @user}
      end
      
      it "should not be successful" do
        assigns[:user].should be_new_record
        response.should render_template("new")
      end
    end
  end
  
  describe "edit profile" do
    
    before(:each) do
      @user = Factory(:user, :email => "user@example.com")
      user_session = stub(:user => @user, :record => @user, :destroy => true)
      UserSession.stub!(:find).and_return(user_session)
    end
    
    describe "edit a user" do
      before(:each) do
        get :edit, {:id => @user.id}
      end
      it "should render edit form" do
        assigns[:user].should == @user
        assigns[:user].job_histories.size.should == 7
        response.should render_template("edit")
      end
    end
  end

end
