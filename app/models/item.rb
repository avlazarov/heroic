class Item < ActiveRecord::Base
  belongs_to :inventory
  
  validates_presence_of :name
  #validates_presence_of :inventory, message: ' is blank or invalid'
  validates_numericality_of :defense
  validates_numericality_of :attack
  validates_numericality_of :life
  validates_numericality_of :experience_bonus

  # not using inventory object, because Inventory.new may be passed and item.valid? will return true
  def self.generate(item_level)
    random = Random.new
    params = {}

    lower = item_level - 5 > 0 ? item_level - 5 : 0
    upper = item_level + 10
    range = lower..upper
    
    params[:name]    = Item.generate_name + item_level.to_s # TODO item name config
    params[:attack]  = random.rand(range) / random.rand(5..7)
    params[:defense] = random.rand(range) / random.rand(5..7)
    params[:life]    = random.rand(range) / 10
    params[:experience_bonus] = random.rand(range) / 20

    Item.new params
  end

  def belongs_to?(player)
    player and player.inventory == inventory # TODO check inventory ids
  end

  private

  def self.generate_name
    'item_of_level_'
  end
end
