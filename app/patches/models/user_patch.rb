require_dependency 'user'
require 'rubygems'
require 'rotp'

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
        AuthSourceTotp.find_or_create_by(user_id: self.id)
      end

      def auth_secret
        self.auth_source_totp.auth_secret
      end

      def auth_secret=(arg)
        oob = self.auth_source_totp
        oob.auth_secret = arg
        oob.save
      end

      def generate_auth_secret
		self.auth_secret = ROTP::Base32.random_base32
      end


      def valid_verification_code?(code)
        return false if code.blank?
		totp = ROTP::TOTP.new(self.auth_secret)
        return totp.verify(code)
      end

    end
  end
end

TotpAuth::UserPatch.tap do |mod|
  User.send :include, mod unless User.include?(mod)
end
