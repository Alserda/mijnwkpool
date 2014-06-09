class QuarterpredictionsController < ApplicationController
  before_action :quarterteams, :only => [:show, :edit]  
  before_filter :ensure_admin, :only => [:pointsscript, :pointsscript2, :givepoints, :givepoints2]
  respond_to :html, :json
  def index
    @pool = Pool.find(params[:pool_id])
    @games = Game.all
    @predictions = Prediction.all
  end

  def show
    @pool = Pool.find(params[:id])
    @gameseight = Game.where(gametype: 'Achtste finale').order(date: :asc)
    @gamesquarter = Game.where(gametype: 'Kwart finale').order(date: :asc)    
    @gameseightlist = @gameseight.group_by { |t| t.gametype }
    @gamesquarterlist = @gamesquarter.group_by { |t| t.gametype }    
  end

  def quarterteams
    @pool = Pool.find(params[:id])
    poolmem = Poolmembership.find_by_user_id_and_pool_id(current_user.id, @pool.id).id
    @predictionarray = [
      { #1
        team1: {
          game_id: 101,
          final: 4,
          poolmembership_id: poolmem                   
        },
        team2: {
          game_id: 102,
          final: 4,
          poolmembership_id: poolmem                     
        }
      },
      { #2
        team1: {
          game_id: 103,
          final: 4,
          poolmembership_id: poolmem                   
        },
        team2: {
          game_id: 104,
          final: 4,
          poolmembership_id: poolmem                     
        }
      },
      { #3
        team1: {
          game_id: 105,
          final: 4,
          poolmembership_id: poolmem                   
        },
        team2: {
          game_id: 106,
          final: 4,
          poolmembership_id: poolmem                     
        }
      },
      { #4
        team1: {
          game_id: 107,
          final: 4,
          poolmembership_id: poolmem                   
        },
        team2: {
          game_id: 108,
          final: 4,
          poolmembership_id: poolmem                     
        }
      }               
    ] 
  end

  def create
    @predictions = Prediction.new(prediction_params)
    if @prediction.save
      redirect_to app_root_path
    else
      render 'new'
    end
  end

  def edit
    @pool = Pool.find(params[:id])
    @gamesquarter = Game.where(gametype: 'Kwart finale').order(date: :asc)
    @gamesquarterlist = @gamesquarter.group_by { |t| t.gametype }
    @gamesquarterlist.sort.each_with_index do |(gametype, games), index|    
      if @present
        return
      else
        @gamesquarter.each_with_index do |game, index2|
          current_poolmembership = Poolmembership.find_by_user_id_and_pool_id(current_user.id, @pool.id)
          prediction = Prediction.find_by_poolmembership_id_and_game_id(current_poolmembership, game.id)

          if prediction.present?
            @present = true
          end
        end
      end
    end
    if @present
      render 'edit'
    else
      render 'new'
    end     
  end

  private

  def find_poolmembership
    @poolmembership ||= Poolmembership.find(params[:poolmembership_id])
  end

  def quarterprediction_params
    params.require(:knockoutprediction).permit(:prediction, :id, :score1, :game, :prediction1, :prediction2, :game_id, :poolmembership_id, :pool_id, :team1_id, :team2_id)
  end
end







 