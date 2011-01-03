# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class Error404 < StandardError; end

class ApplicationController < ActionController::Base
  
  rescue_from Error404, :with => :render_404

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :current_user
  filter_parameter_logging "password" 

  before_filter :authorize
  skip_before_filter :authorize, :only => :home

  def home
    respond_to do |format|
      if current_user.present?
        format.html { redirect_to user_url(current_user.id)}
      else
        format.html { redirect_to new_activation_url }
      end
    end
  end
  
  private
  
  def authorize
    respond_to do |format|
      format.html { redirect_to login_url }
    end unless current_user.present?
  end

  def current_user_session  
    return @current_user_session if defined?(@current_user_session)  
    @current_user_session = UserSession.find  
  end  
    
  def current_user  
    return @current_user if defined?(@current_user)
    this_current_user = current_user_session && current_user_session.user 
    if this_current_user
      @current_user = User.find_by_id(this_current_user.id)
    else
      @current_user = nil
    end
    @current_user
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
