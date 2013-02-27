class SessionsController < ApplicationController
  skip_before_filter :authorize

  def new
  end

  def create
    if User.count.zero?
      user = User.create(name: "rails_temp_user", password:params[:password], password_confirmation: params[:password])
      session[:user_id] = user.id
      redirect_to new_user_path, alert: 'You should create user with admin rights to disable anonymous logon'
      return
    end

    user = User.find_by_name(params[:name])
    if user and user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to admin_url
    else
      redirect_to login_url, alert: "Wrong login password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: "Session closed."
  end
end
