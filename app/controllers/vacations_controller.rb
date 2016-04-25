class VacationsController < ApplicationController
  respond_to :json
  def create
    Vacation.create! :user_id => params[:userId], :vacation_type => params[:type], :start_date => params[:startDate],
                     :end_date => params[:endDate], :reason => params[:reason]

    render nothing: true, status: :ok
  end
end