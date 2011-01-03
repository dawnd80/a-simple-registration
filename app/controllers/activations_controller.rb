class ActivationsController < ApplicationController
  skip_before_filter :authorize

  def new
    @activation = Activation.new(:activated => false)
    respond_to do |format|
      format.html
    end
  end
  
  def create
    @activation = Activation.new(params[:activation])
    respond_to do |format|
      if @activation.save
        UserMailer.deliver_registration_confirmation(@activation)
        format.html
      else
        format.html { render :action => "new" }
      end
    end
  end
  
end