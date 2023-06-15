class User < ApplicationRecord


    def generate_otp
        # if self.otp_created_at.present? && (self.otp_created_at < (DateTime.now - 5.minutes))
        # end
        self.otp = (SecureRandom.random_number(9e5) + 1e5).to_i.to_s
        self.otp_created_at = DateTime.now
        self.save
    end
end
