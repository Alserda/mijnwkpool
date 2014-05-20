class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:success] = 'Team toegevoegd.'
      redirect_to teams_path
    else
      render 'new'
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
  end


  private

  def team_params
    params.require(:team).permit(:name, :poule, :avatar)
  end
end