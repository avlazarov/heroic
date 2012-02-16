module CustomMatchers
  RSpec::Matchers.define :be_logged_in do
    match do |account|
      account.id == session[:user_id]
    end

    failure_message_for_should do |account|
      "expected that #{account} would be a logged in"
    end

    failure_message_for_should_not do |account|
      "expected that #{account} would not be a logged in"
    end

    # for describe account do ; it { should be_logged_in } ... ; end
    description do
      'be a logged in'
    end
  end

  RSpec::Matchers.define :deny_access do
      match do |response|
        response.request.flash[:error].present? and response.redirect_url == 'http://test.host/account/login'
      end

      failure_message_for_should do |response|
        'expected action to deny access'
      end
  end
end
