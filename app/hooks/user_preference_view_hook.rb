module TOTPAuth
  class UserPreferenceViewHooks < Redmine::Hook::ViewListener
    render_on :view_my_account_preferences, partial: 'totp_auths/preferences'
    render_on :view_users_form_preferences, partial: 'totp_auths/preferences'
  end
end
