module TotpAuth
  class AccountControllerHooks < Redmine::Hook::ViewListener
    def controller_account_success_authentication_after(context = {})
      user, request = context.values_at(:user, :request)

      if user.enabled_totp_auth?
        request.session[:oob] = '1'
      end
    end

  end
end
