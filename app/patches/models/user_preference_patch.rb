require_dependency 'user_preference'

module TOTPAuth
  module UserPreferencePatch
    extend ActiveSupport::Concern
    unloadable

    included do
      unloadable
      include Redmine::SafeAttributes

      safe_attributes 'enabled_totp_auth'
    end

    def enabled_totp_auth; self[:enabled_totp_auth] || '0'; end
    def enabled_totp_auth=(value); self[:enabled_totp_auth]=value; end

  end
end

TOTPAuth::UserPreferencePatch.tap do |mod|
  UserPreference.send :include, mod unless UserPreference.include?(mod)
end
