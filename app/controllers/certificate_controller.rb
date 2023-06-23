class CertificateController < ApplicationController
  def index

    if (current_user)
      @user = current_user
      @certificate = Certificate.where(user: current_user).first
      @certificate = Certificate.new if @certificate.blank?
    else
      redirect_to root_path if !current_user
    end

  end

  def show

    @certificate = Certificate.find_by(user: current_user)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "hello-filename", template: "certificate/show", formats: [:html],
               orientation: "Landscape"
      end
    end

  end
  
  def new
  end

  def create_certificate
    begin
      @certificate = Certificate.where(user: current_user).first
      if (@certificate)
        Certificate.update!(certificate_params)
      else
        @certificate = Certificate.where(certificate_params).first_or_create!
      end


      redirect_to certificate_show_path
      redirect_to certificate_show_path(u: certificate_params[:user_id],c:@certificate.id)
    rescue StandardError => e
      # Handle the error here
      puts "An error occurred while creating the certificate: #{e.message}"

    end
  end
  def preview

  end

  def download
    @certificate = Certificate.find_by(user: current_user)
    if current_user.present? && @certificate.present?
      @certificate.download_count = @certificate.download_count.to_i + 1
      @certificate.save
    end
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@certificate.name}s certificate", template: "certificate/download",
               formats: [:html],
               layout: 'pdf',
               orientation: "Landscape"

      end
    end


  end


  private
  def certificate_params
    params.require(:certificate).permit(:name, :address, :zila, :lok_sabha, :state, :user_id, :date)
  end
end
