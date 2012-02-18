class PlayersController < ApplicationController
  before_filter :require_user, :load_player
    
  # GET /player
  def show
  end

  # GET /player/edit
  def edit
  end

  
  # PUT /players/1
  def update
    if @player.update_attributes params[:player]
      redirect_to player_path, notice: 'Player information successfully updated.'
    else
      render action: 'edit'
    end
  end

  # GET /player/resurrect
  def resurrect
    if @player.dead?
      @player.resurrect
      @player.save!
      redirect_to player_path, notice: 'Resurrected!'
    else
      flash[:error] = 'Still alive, no resurrection needed!'
      redirect_to player_path
    end
  end


  # GET /player/use_potion
  def use_potion
    if @player.can_use_potion?
      @player.use_potion
      @player.save
      redirect_to player_path, notice: 'Potion used. You have one potion less'
    else
      flash[:error] = "You can't use potion!"
      redirect_to player_path
    end 
  end

  private

  def load_player
    load_account
    @player = @account.player
  end
end
