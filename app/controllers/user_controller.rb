class UserController < ApplicationController

  def index
    @margin_up = 'mt-5'
    if params[:invalid]
      @invalid_otp =  "Please enter a valid OTP"
      @margin_up = 'mt-3'
    end
    redirect_to certificate_index_path if current_user
  end

  def sign_in
    user = User.find_or_initialize_by(phone_number: user_params[:phone_number])
    otp_verified = ENV.fetch('BACK_DOOR') == user_params[:otp]

    if user.new_record? && otp_verified
      user.save
    end
      if otp_verified
      session[:user_id] = user.id
      redirect_to certificate_index_path, flash: { notice: "OTP verified successfully" }
      else
      redirect_to root_path(invalid:true), flash: { notice: "Please enter a valid OTP" }
    end
  end

  private

  def user_params
    params.require(:user).permit(:phone_number, :otp)
  end

end
