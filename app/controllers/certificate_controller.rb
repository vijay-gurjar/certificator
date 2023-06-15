class CertificateController < ApplicationController
  def index
  end

  def new
  end

  def create_certificate
    puts 'okay data'
    @certificate = Certificate.where(user_id: 1, name: params[:name], address: params[:address], zila: params[:zila]).first

    if @certificate.blank?
    @certificate = Certificate.create!(certificate_params)
    end

    redirect_to download_certificate_path
  end
  
  def download
  end




  private
  def certificate_params
    params.require(:certificate).permit(:name, :address, :district, :parliamentary_constituency, :state, :date, :user_id)
  end
end
