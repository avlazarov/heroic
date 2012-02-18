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

  RSpec::Matchers.define :redirect_with_error_to do |path|
    match do |response|
      response.request.flash[:error].present? and response.redirect_url == 'http://test.host' + path
    end

    failure_message_for_should do |response|
      error_msg = response.request.flash[:error].present? || 'no error'
      "expected action to redirect to http://test.host##{path} with errors\n" +
      "got redirect to #{response.redirect_url} with error #{error_msg}"
    end
  end

  RSpec::Matchers.define :redirect_without_error_to do |path|
    match do |response|
      not response.request.flash[:error].present? and response.redirect_url == 'http://test.host' + path
    end

    failure_message_for_should do |response|
       error_msg = response.request.flash[:error].present? || 'no error'
      "expected action to redirect to http://test.host#{path} without errors\n" +
      "got redirect to #{response.redirect_url} with error #{error_msg}"
    end
  end
end
