class Api::TeamsController < ApplicationController
  def index
    render json: [1,2,3,4]
  end

  def show
    team = Team.find(params[:id])
    render json: team
  end

  def create
    team = Team.create(team_params)
    render json: team
  end

  def update
    team = Team.find(params[:id])
    team.update_attributes(team_params)
    render json: team
  end

  private
  def team_params
    return params.permit(:name, :participants_count, :drive_in_mountains, 
      :use_snow_chains, :other_special_requirements, :accept_terms_conditions)
  end
end