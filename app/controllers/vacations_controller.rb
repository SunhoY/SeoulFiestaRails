class VacationsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json
  def create
    vacation = Vacation.create! :user_id => params[:userId], :vacation_type => params[:type],
                                :reason => params[:reason], :vacation_status => 'requested'

    start_date = Date.parse params[:startDate]
    end_date = Date.parse params[:endDate]

    (start_date..end_date).each { |d|
      VacationItem.create! :vacation_id => vacation.id,
                           :vacation_date => d
    }

    render nothing: true, status: :ok
  end

  def index
    user_id = params[:userId]

    vacations = Vacation.where(:user_id => user_id)

    render :json => vacations.to_json(:include => :vacation_items, :except => :user_id)
  end
end