module TotpAuth
  class UserPreferenceViewHooks < Redmine::Hook::ViewListener
    render_on :view_users_form_preferences, partial: 'totp_auths/preferences'
	def generate_auth_secret()
	logger.error "I've been activated"
	end
  end
end
