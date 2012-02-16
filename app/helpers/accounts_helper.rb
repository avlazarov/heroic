require 'digest/md5'

module AccountsHelper
  def encrypt(string)
    if string
      Digest::MD5.hexdigest string
    else
      ''
    end
  end
end
