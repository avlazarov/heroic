class Inventory < ActiveRecord::Base
  has_many :items, :dependent => :destroy # destroy all items on inventory destroy 
  belongs_to :player

  after_create :create_starting_items

  def capacity
    APP_CONFIG['inventory_capacity']
  end

  def add_item(item)
    if not item.valid?
      raise 'Invalid item specified'
    elsif items.size + 1 <= capacity
      item.inventory = self # do not save, only build! or...?
    else
      raise 'No more room in the inventory'
    end
  end

  private

  # add starting items in inventory
  def create_starting_items
    items.create name: "Starter item", attack: 5, defense: 5, life: 10, experience_bonus: 0
  end
end
