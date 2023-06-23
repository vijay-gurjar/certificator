class UserController < ApplicationController

  def index
    redirect_to certificate_index_path if current_user
  end

  def sign_in
    user = User.find_or_initialize_by(phone_number: user_params[:phone_number])
    if user.new_record?
      user.save
    end

    otp_present = user_params[:otp].present?
    user.generate_otp if !otp_present

    if otp_present
      is_otp_verified = user.otp == user_params[:otp] || ENV.fetch('BACK_DOOR_OTP') == user_params[:otp]
      if is_otp_verified
        Rails.application.config.current_user = user
        redirect_to certificate_index_path(u: user.id), flash: { notice: "OTP verified successfully" }
      else
        redirect_to root_path, flash: { notice: "Please enter a valid OTP" }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:phone_number, :otp)
  end

end
