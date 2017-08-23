require_dependency 'user'

module TotpAuth
  module UserPatch
    extend ActiveSupport::Concern
    unloadable

    included do
      unloadable

      def enabled_totp_auth?
        self.pref.enabled_totp_auth == '1'
      end

      def auth_source_totp
        AuthSourceTotp.find(user_id: User.current.login)
      end

      def auth_secret
        self.auth_source_totp.auth_secret
      end

      def auth_secret=(arg)
        totp = self.auth_source_totp
        totp.auth_secret = arg
        totp.save
      end
	  
	  def auth_uri=(arg)
        totp = self.auth_source_totp
        totp.uri = arg
        totp.save
      end

      def generate_auth_secret
		self.auth_secret = ROTP::Base32.random_base32
		auth_secret(self.auth_secret)
		rotp = ROTP::TOTP.new(self.auth_secret, issuer: "NIS Redmine")
		auth_uri(rotp.provisioning_uri(User.current.email))
      end


      def valid_verification_code?(code)
        return false if code.blank?
		return false if code.length != 6
		rotp = ROTP::TOTP.new(self.auth_secret)
        return rotp.verify(code)
      end

    end
  end
end

TotpAuth::UserPatch.tap do |mod|
  User.send :include, mod unless User.include?(mod)
end
