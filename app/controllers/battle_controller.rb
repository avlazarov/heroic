class BattleController < ApplicationController
  before_filter :require_user, :load_account

  # GET /battle/start
  def start
    player = @account.player
    if player.dead?
      flash[:error] = 'Your player is dead, cannot go in battle!'
      redirect_to player_path
    else
      monster = Monster.random_by_level_between player.level - 5, player.level + 2
      monster ||= Monster.default(player.level)

      life_lost = outcome player, monster

      @life_lost = life_lost

      player.current_life_percent -= 100.0 * life_lost / player.total_life
      player.save

      if not player.dead?
        @items_received = 0

        @experience_recieved = monster.experience_given
        @potions_received = ([0] * 10 + [1] * 2 +  [2]).sample

        items = items_dropped monster.level

        begin
          items.each do |item|
            player.add_item item
            item.save
            player.reload
            @items_received += 1
          end
        rescue Exception => ex
          flash[:error] = ex.message
        end

        player.potions    += @potions_received
        player.experience += @experience_recieved
      end

      player.save
      @player = player
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
