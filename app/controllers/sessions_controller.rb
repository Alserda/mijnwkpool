class SessionsController < ApplicationController
  skip_before_filter :ensure_user

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to app_root_path
    else
      flash[:error] = 'Incorrecte combinatie.'
      redirect_to :back
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
