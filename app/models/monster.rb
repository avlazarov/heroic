class Monster < ActiveRecord::Base
  validates :name, :presence => true,
                   :format => { :with => /\A[[:alpha:]]+\z/, 
                                :message => 'only letters allowed' }
  validates_numericality_of :level
  validates_numericality_of :attack
  validates_numericality_of :defense
  validates_numericality_of :life
  validates_numericality_of :experience_given

  def self.random_by_level_between(lower, upper)
    found_monsters = where(level: lower..upper)
    found_monsters.sample
  end

  def self.default(level)
    Monster.new name: 'Unnamed', attack: level, defense: level,
                life: level * 2, experience_given: level * 100, level: level 
  end
end
