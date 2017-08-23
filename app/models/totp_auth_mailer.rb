require_dependency 'mailer'

class TotpAuthMailer < Mailer
  def verification_code(user)
    @message = l("%{code} is your SK", code: user.verification_code)
    title = l("%{value}", value: Setting.app_title)

    mail(to: user.mail, subject: title)
  end

end