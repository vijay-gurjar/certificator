class AdminController < ApplicationController
  before_action :check_uniq_users

  def index
    @total_users = User.all.distinct.order(id: :asc)
    @total_certificates = Certificate.all.distinct.order(id: :asc)
    @state_wise_report = Certificate.group(:state).count
    @zila_wise_report = Certificate.group(:zila).count
    @lok_sabha_wise_report = Certificate.group(:lok_sabha).count
  end

  def check_uniq_users
      redirect_to root_path if !check_valid_user
  end

  def check_valid_user
     ENV.fetch("UNIQ_PHONE_NUMBERS").include?(current_user.phone_number)
  end
end
