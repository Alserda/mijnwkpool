class ApplicationController < ActionController::Base
  before_filter :ensure_user, :except => [:home]
  before_filter :deadline

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  def deadline
    Time.zone.parse('2014-06-12 21:00:00')
  end

  def welcome
  end

  private

  def second_user
    @second_user ||= User.find(2) # (session[:user_id]) if session[:user_id]
  end

  def ensure_user
    if current_user
    else
    "ensure_user"
    flash[:error] = 'Registreer of log in om deze pagina te bekijken.'
    redirect_to root_path
    end
  end

  def ensure_admin
    if current_user.try(:admin?)
    else
      "ensure_admin"
      flash[:error] = 'Je hebt niet genoeg rechten om deze pagina te bekijken.'
      redirect_to app_root_path
    end
  end
end