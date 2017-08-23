class TotpAuthsController < ApplicationController
  unloadable
  before_action :require_login

  skip_before_action :check_totp_auth

  def login
    if session[:totp].present?
      totp_authentication if request.post?
    else
      redirect_back_or_default home_url, referer: true
    end
  rescue => e
    logger.error "An error occurred when authenticating #{User.current.login}: #{e.message}"
    render_error message: e.message
  end

  def generate_as_uri()
	AuthSourceTotp.generate_as_uri()
  end
  
  private

    def totp_authentication
      user = User.current
      if user.valid_verification_code?(params[:password])
        session.delete(:totp)

        redirect_back_or_default my_page_path
      else
        logger.warn "Failed OTP authentication for '#{User.current.login}' from #{request.remote_ip} at #{Time.now.utc}"
        flash.now[:error] = "The OTP #{l('activerecord.errors.messages.invalid')}"
      end
    end

end
