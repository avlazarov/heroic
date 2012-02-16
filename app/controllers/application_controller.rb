class ApplicationController < ActionController::Base
  protect_from_forgery

  # so can be used in views
  helper_method :logged_in?

  private

  def require_user
    unless logged_in?
      flash[:error] = 'Not logged in!'
      redirect_to login_account_path
    end
  end

  def logged_in?
    session[:user_id]
  end

  def load_account
    @account = Account.find session[:user_id]
  end
end
