class AuthSourceTotp < ActiveRecord::Base
  include Redmine::Ciphering

  has_many :users
  def generate_as_uri()
	totp = self.auth_source_totp
    totp.auth_secret = ROTP::Base32.random_base32
	rotp = ROTP::TOTP.new(totp.auth_secret, issuer: "NIS Redmine")
	totp.uri = rotp.provisioning_uri(User.current.email)
    totp.save
  end
  
  def auth_secret
    read_ciphered_attribute(:auth_secret)
  end

  def auth_secret=(arg)
    write_ciphered_attribute(:auth_secret, arg)
  end
end
