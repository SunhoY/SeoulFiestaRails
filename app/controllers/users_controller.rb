class UsersController < ApplicationController
  respond_to :json
  def show
    user = User.find(params[:id])

    if user
      render :json => user
    else
      render :nothing => true, :status => :not_found
    end
  end
end