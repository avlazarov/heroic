class InventoriesController < ApplicationController
  before_filter :require_user, :load_inventory

  # GET /inventory
  def show
    @items = @inventory.items
  end

  private

  def load_inventory
    load_account
    @inventory = @account.player.inventory
  end
end
