class Player < ActiveRecord::Base
  MAX_LIFE_PERCENT = 100
  MIN_LIFE_PERCENT = 0
  
  has_one :inventory, :dependent => :destroy # destroy inventory on player destroy
  has_many :items, :through => :inventory
  belongs_to :account, :dependent => :destroy # destroy account on player destroy
  belongs_to :player_class
  
  validates :name, :presence => true, :format => { :with => /\A[[:alpha:]]+\z/, :message => 'only letters allowed' }

  # check if the player_class really exists
  validates_presence_of :player_class, :message => 'is not specified or does not exist'

  validates_uniqueness_of :name, :if => -> { name.present? }
  validates_numericality_of :potions

  validates :current_life_percent, :numericality => true, :inclusion => MIN_LIFE_PERCENT..MAX_LIFE_PERCENT
  validates_numericality_of :experience

  after_create :add_inventory # create inventory on player create

  def current_life
    0.01 * total_life * current_life_percent
  end

  # total life based on items
  def total_life
    items.map(&:life).inject(0) { |sum, current| sum += current }
  end

  # attack based on player class and items
  def attack
    total_for(:attack) 
  end

  # defense based on player class and items
  def defense
    total_for(:defense)
  end

  # experience bonus based on player class and items
  def experience_bonus
    total_for(:experience_bonus)
  end

  # based on experience
  def level
    1 + experience / Rails.application.config.experience_per_level
  end

  def use_potion
    if can_use_potion?
      self.potions -= 1
      update_life_percent Rails.application.config.potion_heal_percent
    end
  end

  def can_use_potion?
    potions > 0 and current_life_percent < MAX_LIFE_PERCENT and not dead?
  end

  def resurrect
    if dead? 
      self.experience = (self.experience * (1 - Rails.application.config.experience_percent_lost * 0.01)).to_i
      self.current_life_percent = MAX_LIFE_PERCENT
    end
  end

  def dead?
    current_life_percent == MIN_LIFE_PERCENT
  end

  def add_item(item_params)
    inventory.add_item item_params
  end

  private

  def add_inventory
    create_inventory
  end

  def total_for(attribute)
    items.map(&attribute).inject(player_class.send(attribute)) { |sum, current| sum + current }
  end

  # do not use before_save, because current_life_percent may be 
  # changed multiple times before saving
  def update_life_percent(amount)
    sum = self.current_life_percent + amount
    self.current_life_percent = [[sum, MAX_LIFE_PERCENT].min, MIN_LIFE_PERCENT].max
  end
end
