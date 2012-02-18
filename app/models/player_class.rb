class PlayerClass < ActiveRecord::Base
  has_many :players, :dependent => :destroy

  validates :name, :uniqueness => true,
                   :presence => true, 
                   :format => { :with => /\A[[:alpha:]]+\z/, 
                                :message => 'only letters allowed' }
  validates_numericality_of :defense
  validates_numericality_of :attack
  validates_numericality_of :experience_bonus
end
