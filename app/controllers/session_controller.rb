class SessionController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user == nil
      render nothing: true, status: :not_found
    elsif user.authenticate(params[:password])
      @session = Session.create(:user => user)
      render json: {:token => @session.token}, status: :ok
    else
      render nothing: true, status: :unauthorized
    end
  end
end