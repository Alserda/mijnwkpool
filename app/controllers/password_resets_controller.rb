class PasswordResetsController < ApplicationController
  skip_before_filter :ensure_user

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    flash[:success] = "E-mail verstuurd met een wachtwoord herstel instructies."
    redirect_to root_url
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(password_reset_params)
      flash[:success] = "Het wachtwoord is hersteld."
      redirect_to root_url
    else
      render :edit
    end
  end

  private

  def password_reset_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
