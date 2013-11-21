require 'csv'
class Admin::TeamsController < ApplicationController
  def index
    respond_to do |format|
      format.html { @teams = Team.order_by(:name => 1) }
      format.xls { send_data Team.to_csv(col_sep: "\t") }
    end    
  end

  def drivers_index
    respond_to do |format|
      format.xls { send_data Team.drivers_csv(col_sep: "\t") }
    end
  end

  def show
    @team = Team.find(params[:id])
  end
end
