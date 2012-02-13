class PlayersController < ApplicationController
  before_filter :require_user, :load_player
    
  # GET /player
  def show
  end

  # GET /player/edit
  def edit
  end

  # GET /player/resurrect
  def resurrect
    if @player.dead?
      @player.resurrect
      @player.save!
      redirect_to player_path, notice: 'Resurrected!'
    else
      redirect_to player_path, notice: 'Still alive, no ressurection needed!'
    end
  end

  # GET /player/battle
  def battle
    if @player.dead?
      redirect_to player_path, notice: 'Your player is dead, cannot go in battle!'
    end

    @items_received = 0
    begin
      Random.new.rand(0..2).times do
        @player.add_item Item.generate(10) # TODO FIX
        @items_received += 1
      end
    rescue Exception => ex
      flash[:error] = ex.message
    end
    
    @experience_recieved = 0
    @potions_received = ([0] * 10 + [1] * 2 +  [2]).sample

    @player.potions += @potions_received
    @player.inventory.save
    @player.save
  end

  # GET /player/use_potion
  def use_potion
    @player.use_potion
    @player.save

    redirect_to player_path
  end

  # PUT /players/1
  def update
    respond_to do |format|
      if @player.update_attributes params[:player]
        format.html { redirect_to player_path, notice: 'Player information successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
end
