class CertificateController < ApplicationController
  def index
    if (current_user)
      @user= current_user
      @certificate = Certificate.where(user: current_user).first
      @certificate = Certificate.new if @certificate.blank?
    else
      redirect_to root_path if !current_user
    end

  end

  def show
    @certificate = Certificate.find_by(user: current_user,id:params[:c])
    respond_to do |format|
      format.html
      render layout: 'preview'
      format.pdf do
        render pdf: "hello-filename", template: "certificate/show", formats: [:html],
               orientation: "Landscape"
      end
    end

  end
  
  def new
    # "google-site-verification=EQo2itG2fMKjCdPrAZjnaaNPrKTDTGM5kDUv00upxWc"
  end

  def create_certificate
    begin
      @certificate = Certificate.where(user_id: certificate_params[:user_id]).first
      if (@certificate)
        @certificate.update!(certificate_params)
      else
        @certificate = Certificate.where(certificate_params).first_or_create!
      end

      c_number_series = "BMM/23-"
      c_number = ''

      if (@certificate.certificate_number.nil?)
        c_id = @certificate.id.to_s.length
        if (c_id == 1)
          c_number = "100#{@certificate.id}"
        elsif (c_id == 2)
          c_number = "10#{@certificate.id}"
        elsif (c_id == 3)
          c_number = "1#{@certificate.id}"
        elsif (c_id >= 4)
          c_number = "#{@certificate.id}"
        end
        @certificate.certificate_number = c_number_series + c_number
        @certificate.save
      end

      redirect_to certificate_show_path(c: @certificate.id)
    rescue StandardError => e
      # Handle the error here
      puts "An error occurred while creating the certificate: #{e.message}"

    end
  end
  def preview

  end

  def download
    @certificate = Certificate.find_by(user: current_user,id:params[:c])
    if @certificate.present?
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
    params.require(:certificate).permit(:name, :address, :zila, :lok_sabha, :state, :user_id, :date, :certificate_number)
  end
end
