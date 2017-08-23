class AuthSourceTotp < ActiveRecord::Base
  include Redmine::Ciphering

  has_many :users

  def auth_secret
    read_ciphered_attribute(:auth_secret)
  end

  def auth_secret=(arg)
    write_ciphered_attribute(:auth_secret, arg)
  end
end
