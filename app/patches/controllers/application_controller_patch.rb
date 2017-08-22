require_dependency 'application_controller'

module TOTPAuth
  module ApplicationControllerPatch
    extend ActiveSupport::Concern
    unloadable

    included do
      unloadable

      before_action :check_totp_auth

      def check_totp_auth
        return true if controller_name == 'account'
        return true if session[:pwd].present?

        if session[:oob]
          if User.current.enabled_totp_auth?
            redirect_to controller: 'totp_auths', action: 'login'
          else
            session.delete(:oob)
          end
        end
      end

    end

  end
end

OutOfBandAuth::ApplicationControllerPatch.tap do |mod|
  ApplicationController.send :include, mod unless ApplicationController.include?(mod)
end
