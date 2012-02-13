class Account < ActiveRecord::Base
  has_one :player, :dependent => :destroy

  validates :username, :presence => true,
                       :uniqueness => true,
                       :length => { :within => 2..30 },
                       :format => { :with => /\A[[:alpha:]][[:word:]]*\z/, :message => "should start with letter" }

  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 6..30 }
end
