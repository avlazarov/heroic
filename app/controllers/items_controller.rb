class ItemsController < ApplicationController
  before_filter :require_user, :load_account

  # DELETE /items/1
  def destroy
    @item = Item.find params[:id]
    if @item and @item.belongs_to? @account.player
      @item.destroy
      redirect_to inventory_path, notice: "Item '#{@item.name}' successfully removed!"
    else
      redirect_to inventory_path, notice: "Invalid or someone else's item"
    end
  end
end
