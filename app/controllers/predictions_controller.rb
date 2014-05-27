class PredictionsController < ApplicationController
  respond_to :html, :json

  def index
    @pool = Pool.find(params[:pool_id])
    @games = Game.all
    @predictions = Prediction.all
  end

  def new
    @pool = Pool.find(params[:pool_id])
    @games = Game.order(:poule)
    # @predictions = Prediction.all
    @gamelist = @games.group_by { |t| t.poule }
  end

  def create
    @predictions = Prediction.new(prediction_params)
    if @prediction.save
      redirect_to app_root_path
    else
      render 'new'
    end
  end

  def create_multiple_predictions
    params[:predictions].each do |k, v|
      prediction = Prediction.new(v)
      prediction.save
    end
    redirect_to app_root_path
  end

  def edit
  end

  def show
    @pool = Pool.all
    @games = Game.all
    @predictions = Prediction.all
  end

  def update
    @prediction = Prediction.find(params[:id])
    @prediction.update_attributes(prediction_params)
    respond_with @prediction
  end

  def givepoints
    @games = Game.all
    @predictions = Prediction.all
  end

  private

  def find_poolmembership
    @poolmembership ||= Poolmembership.find(params[:poolmembership_id])
  end

  def prediction_params
    params.require(:prediction).permit(:prediction, :id, :score1, :game, :prediction1, :prediction2, :game_id, :poolmembership_id, :pool_id, :team1_id, :team2_id)
  end
end
