class UserController < ApplicationController

    def sign_in
        @user = User.where(phone_number: params[:phone_number]).first_or_create!

        if params[:otp].blank?
                @user.generate_otp 
        end

        if params[:otp]
        is_otp_verified = @user.otp == params[:otp]

        redirect_to root_path, notice: "Please enter valid OTP" if !is_otp_verified
        redirect_to index_path, notice: "OTP verified Succesfully" if is_otp_verified
        end
    end


    private
    def user_params
        params.require(:user).permit(:phone_number)
      end
end
