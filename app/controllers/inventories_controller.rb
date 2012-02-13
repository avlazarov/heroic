class InventoriesController < ApplicationController
  before_filter :require_user, :load_player, :load_inventory

  # GET /inventory
  def show
    @items = @inventory.items
  end

  private
  def load_inventory
    @inventory = @player.inventory
  end
end
