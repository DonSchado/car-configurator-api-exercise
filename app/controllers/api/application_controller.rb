module API
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    before_filter :authenticate

    protected

    def authenticate
      authenticate_or_request_with_http_basic do |email, password|
        # you probably want to guard against a wrong email, and encrypt the
        # password but this is the idea.
        @user = User.find_by_email(email)
        @user.password == password && @user.permission
      end
    end
  end
end
