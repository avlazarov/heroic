module Support
  module ControllerHelpers
    def log_in(account)
      session[:user_id] = account.id
    end

    def log_out
      session[:user_id] = nil
    end
  end
end
