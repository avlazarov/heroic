class BattleController < ApplicationController
  before_filter :require_user, :load_account

  # GET /battle/start
  def start
    @player = @account.player
    if @player.dead?
      flash[:error] = 'Your player is dead, cannot go in battle!'
      redirect_to player_path
    else
      @monster = Monster.random_by_level_between @player.level - 5, @player.level + 2
      @monster ||= Monster.default(@player.level)

      @life_lost = [outcome(@player, @monster), @player.current_life].min

      # update life
      @player.decrease_life_with @life_lost 
      @player.save

      if not @player.dead?
        @items_received = 0
        @potions_received = ([0] * 10 + [1] * 2 +  [2]).sample

        items = items_dropped @monster.level
        
        # receive items
        begin
          items.each do |item|
            @player.add_item item
            item.save
            @player.reload
            @items_received += 1
          end
        rescue Exception => ex
          flash[:error] = ex.message
        end

        # update potions and experience 
        @player.potions += @potions_received
        @player.receive_experience @monster.experience_given
      end

      @player.save
    end
  end

  private

  def items_dropped(level)
    items = []
    Random.new.rand(0..2).times { items << Item.generate(level) }
    items
  end

  def outcome(player, monster)
    if player.attack > 1.5 * monster.defense 
      [5, player.current_life - 1].min
    elsif player.defense > 1.5 * monster.attack
      [10, player.current_life - 1].min
    elsif player.current_life > monster.life
      player.current_life - monster.life
    else # dies :(
      player.current_life
    end
  end
end
