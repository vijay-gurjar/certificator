class AdminController < ApplicationController
  before_action :check_uniq_users
  include AdminHelper

  def index
    @total_users = User.all.distinct.order(id: :asc)
    @total_certificates = Certificate.all.distinct.order(id: :asc)
    @state_wise_report = Certificate.group(:state).count
    @zila_wise_report = Certificate.group(:zila).count
    @lok_sabha_wise_report = Certificate.group(:lok_sabha).count
  end

  def download_data
    modal = params[:type].capitalize.constantize
    if params[:type] == 'user'
      select_attr = "id,phone_number"
    elsif params[:type] == 'certificate'
      select_attr = "name, address, zila, lok_sabha, state"
    end

    data = modal.all.order(name: :asc).select(select_attr)
    file = generate_download_file(data)
    send_file file.path, filename: 'data.csv', type: 'text/csv'
  end


  def download_report
    require 'csv'
    data = Certificate.group(params[:type].to_sym).count
    file = generate_report_data(data)
    send_file file.path, filename: "#{params[:type].capitalize} Report.csv", type: 'text/csv'
  end


  def check_uniq_users
      redirect_to root_path if !check_valid_user
  end

  def check_valid_user
     ENV.fetch("UNIQ_PHONE_NUMBERS").include?(current_user.phone_number)
  end
end
