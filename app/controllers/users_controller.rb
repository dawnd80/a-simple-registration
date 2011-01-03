class UsersController < ApplicationController
  skip_before_filter :authorize, :only => [:new, :create]

  def new
    activation = Activation.find_by_unique_key(params[:key])
    activation.update_attribute('activated', true)
    @user = User.new(:email => activation.email)
    respond_to do |format|
      format.html
    end
  end
  
  def create
    @user = User.new(params[:user])
    @user_session = UserSession.new(:email => params[:user][:email], :password => params[:user][:password])
    respond_to do |format|
      if @user.save
        @user_session.save
        format.html { redirect_to edit_user_url(@user.id, :registering => true)}
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    @registering = params[:registering]
    recorded_jobs = @user.job_histories.size
    (7-recorded_jobs).times { @user.job_histories.build }
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @user = User.find(params[:id])
    edit_params = params[:user]
    edit_params[:job_histories_attributes].delete_if{ |k, v| v[:title].empty? and v[:company].empty? }
    job_deleted = @user.job_history_ids - edit_params[:job_histories_attributes].map{|k, v| v[:id].to_i}
    job_deleted.each{|v|
      job = JobHistory.find(v)
      job.destroy
    }
    respond_to do |format|
      if @user.update_attributes(edit_params)
        format.html { redirect_to user_url(@user.id) }
      else
        recorded_jobs = @user.job_histories.size
        (7-recorded_jobs).times { @user.job_histories.build }
        format.html { render :action => "edit" }
      end
    end
  end
  
  def index
    @users = User.paginate :page => params[:page], :order => 'email asc'
    respond_to do |format|
      format.html
    end
  end
  
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
end