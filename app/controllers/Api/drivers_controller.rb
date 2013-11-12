class Api::DriversController < ApplicationController
  def index
    render json: Team.find(params[:team_id]).drivers.order_by(:name => 1)
  end

  def show
    team = Team.find(params[:team_id])
    driver = team.drivers.find(params[:id])
    return render json: driver
  end

  def create
    team = Team.find(params[:team_id])
    driver = team.drivers.create(params_driver)
    return render json: driver
  end

  def update
    team = Team.find(params[:team_id])
    driver = team.drivers.find(params[:id])
    driver.update_attributes params_driver
    return render json: driver
  end

  def file_upload
    render json: params
  end

  private
  def params_driver
    params[:driver].permit(:type, :name, :delegation, :nationality, :dob, :place_of_birth,
      :street, :city, :country, :phone, :email, :phone_in_italy, 
      :arrival_date, :departure_date, :arrival_time, :departure_time, :documents => []
    )
  end
end
