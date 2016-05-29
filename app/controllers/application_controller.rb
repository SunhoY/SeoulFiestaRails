class ApplicationController < ActionController::Base
  def authenticate_with_session_token
    authenticate_or_request_with_http_token do |token, options|
      @session = Session.find_by_token(token)
      @user = @session.user if @session
      @session && @user
    end
  end
end
