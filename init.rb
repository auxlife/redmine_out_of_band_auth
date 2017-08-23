Redmine::Plugin.register :redmine_totp_auth do
  name 'Redmine TOTP Authentication plugin'
  author 'Auxlife Solutions'
  description 'Redmine plugin that TOTP authentication.'
  version '0.1.1'
  requires_redmine version_or_higher: '3.2.0'
  url 'https://github.com/auxlife/redmine_totp_auth/'
end

require_relative 'lib/totp_auth'