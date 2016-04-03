class SessionsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  respond_to :json
  def create
    @user = User.find_by(email: params[:email], password: params[:password])

    puts @user

    if @user
      render :json => @user
    else
      render nothing: true, status: :not_found
    end
  end
end