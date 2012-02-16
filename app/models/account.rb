class Account < ActiveRecord::Base
  include AccountsHelper

  has_one :player, :dependent => :destroy

  validates :username, :presence => true,
                       :uniqueness => true,
                       :length => { :within => 2..30 },
                       :format => { :with => /\A[[:alpha:]][[:word:]]*\z/, :message => "should start with letter" }

  validates :password, :presence => true,
                       :confirmation => true
  
  validates :password, :length => { :within => 6..30 }, :if => :password_changed? # so when retrieved from database it will be valid

  before_save :encrypt_password, :if => :password_changed?

  private

  def encrypt_password
    self.password = encrypt password
  end
end
