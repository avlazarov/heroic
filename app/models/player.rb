class Player < ActiveRecord::Base
  has_one :inventory, :dependent => :destroy # destroy inventory on player destroy
  has_many :items, :through => :inventory
  belongs_to :account, :dependent => :destroy # destroy account on player destroy
  belongs_to :player_class
  
  validates :name, :presence => true, :format => { :with => /\A[[:alpha:]]+\z/, :message => 'Only letters allowed' }

  validates_presence_of :player_class, :message => 'is not specified or does not exist' # check if the player_class really exists

  validates_uniqueness_of :name, :if => -> { name.present? }
  validates_numericality_of :potions

  validates :current_life_percent, :numericality => true, :inclusion => 0..100
  validates_numericality_of :experience

  after_create :add_inventory # create inventory on player create

  def life
    (0.01 * total_life * current_life_percent).to_i
  end

  # total life based on items
  def total_life
    inventory.items.map(&:life).inject(0) { |sum, current| sum += current }
  end

  # attack based on player class and items
  def attack
    inventory.items.map(&:attack).inject(player_class.attack) { |sum, current| sum += current }
  end

  # defense based on player class and items
  def defense
    inventory.items.map(&:defense).inject(player_class.defense) { |sum, current| sum += current }
  end

  # experience bonus based on player class and items
  def experience_bonus
    inventory.items.map(&:experience_bonus).inject(player_class.experience_bonus) { |sum, current| sum += current }
  end

  # based on experience
  def level
    1 + experience / APP_CONFIG['experience_per_level']
  end

  def use_potion
    if can_use_potion?
      self.potions -= 1
      update_life_percent 10
    end
  end

  def can_use_potion?
    potions > 0 and current_life_percent < 100 and not dead?
  end

  def resurrect
    if dead? 
      self.experience = (self.experience * (1 - APP_CONFIG['experience_percent_lost'] * 0.01)).to_i
      self.current_life_percent = 100
    end
  end

  def dead?
    current_life_percent == 0
  end

  def add_item(item_params)
    inventory.add_item item_params
  end

  private

  def add_inventory
    create_inventory
  end

  # do not use before_save, because current_life_percent may be changed multiple times before saving!
  def update_life_percent(amount)
    self.current_life_percent += amount
    self.current_life_percent = 100 if self.current_life_percent > 100
    self.current_life_percent = 0 if self.current_life_percent < 0
  end
end
