class TOTPAuthsController < ApplicationController
  unloadable
  # self.main_menu = false
  before_action :require_login

  skip_before_action :check_totp_auth

  def login
    if session[:oob].present?
      totp_authentication if request.post?
    else
      redirect_back_or_default home_url, referer: true
    end
  rescue => e
    logger.error "An error occurred when authenticating #{User.current.login}: #{e.message}"
    render_error message: e.message
  end

  private

    def totp_authentication
      user = User.current
      if user.valid_verification_code?(params[:password])
        session.delete(:oob)

        redirect_back_or_default my_page_path
      else
        logger.warn "Failed OTP authentication for '#{User.current.login}' from #{request.remote_ip} at #{Time.now.utc}"
        flash.now[:error] = "#{l(:field_verification_code)} #{l('activerecord.errors.messages.invalid')}"
      end
    end

end
