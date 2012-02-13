class ApplicationController < ActionController::Base
  protect_from_forgery

  # helper_method to be able to use it in view
  helper_method :logged_in?

  private
  def require_user
    redirect_to login_account_path unless logged_in?
  end

  def logged_in?
    session[:user_id]
  end

  def load_player
    @player = Player.find_by_account_id session['user_id']
  end
end
