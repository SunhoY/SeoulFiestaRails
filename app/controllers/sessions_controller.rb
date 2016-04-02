class SessionsController < ApplicationController

  def create
    @user = User.find_by(user_name: params[:user_name], password: params[:password])

    if @user
      render nothing: true, status: :ok
    else
      render nothing: true, status: :not_found
    end
  end
end