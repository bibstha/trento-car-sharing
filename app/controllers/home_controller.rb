class HomeController < ApplicationController
  # def index
  #   @users = User.all
  # end

  def dashboard
    authenticate_user!
    unless current_user.team
      current_user.team = Team.create({})
    end
    @teamId = current_user.team.id
  end
end
