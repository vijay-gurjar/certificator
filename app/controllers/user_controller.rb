class UserController < ApplicationController

  def index
    puts "current user  #{ current_user }"
    redirect_to certificate_index_path if current_user
  end

  def sign_in
    user = User.find_or_initialize_by(phone_number: user_params[:phone_number])

    if user.new_record?
      user.save
    end
        session[:user_id] = user.id
        redirect_to certificate_index_path, flash: { notice: "OTP verified successfully" }
  end

  private

  def user_params
    params.require(:user).permit(:phone_number, :otp)
  end

end
