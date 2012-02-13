class PlayerClass < ActiveRecord::Base
  has_many :players, :dependent => :destroy

  validates :name, :uniqueness => true, :presence => true
  validates_numericality_of :defense
  validates_numericality_of :attack
  validates_numericality_of :experience_bonus
end
