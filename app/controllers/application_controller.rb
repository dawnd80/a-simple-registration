# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class Error404 < StandardError; end

class ApplicationController < ActionController::Base
  
  rescue_from Error404, :with => :render_404

  #before_filter :session_expiry
  #before_filter :authorize

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
