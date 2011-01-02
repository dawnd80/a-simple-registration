class UsersController < ApplicationController
  
  def new
    @user = User.new(:activated => false)
    respond_to do |format|
      format.html
    end
  end
  
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        #send email
        format.html { redirect_to edit_user_url(@user.id) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    recorded_jobs = @user.job_histories.size
    (7-recorded_jobs).times { @user.job_histories.build }
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @user = User.find(params[:id])
    edit_params = params[:user].merge({:activated => true})
    edit_params[:job_histories_attributes].delete_if{ |k, v| v[:title].empty? and v[:company].empty? }
    job_deleted = @user.job_history_ids - edit_params[:job_histories_attributes].map{|k, v| v[:id].to_i}
    job_deleted.each{|v|
      job = JobHistory.find(v)
      job.destroy
    }
    respond_to do |format|
      @user.update_attributes(edit_params)
      format.html { redirect_to user_url(@user.id) }
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