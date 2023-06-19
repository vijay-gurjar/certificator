class CertificateController < ApplicationController
  def index
    @user = User.find(params[:u])
    @certificate = Download.where(user_id: @user.id)
  end

  def show
    @user = User.find(params[:u])
    @certificate = Certificate.find_by(id: params[:c])
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
      @certificate = Certificate.where(certificate_params).first_or_create!
      if @certificate.new_record?
        Download.where(user_id: params[:user_id], certificate_id: @certificate.id).first_or_create! if @certificate.save
      end

      redirect_to certificate_show_path(u: certificate_params[:user_id],c:@certificate.id)
    rescue StandardError => e
      # Handle the error here
      puts "An error occurred while creating the certificate: #{e.message}"

    end
  end
  def preview

  end

  def download
    @user = User.find(params[:u])
    @certificate = Certificate.find_by(id: params[:c])
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

  def render_pdf(html, filename:)
    pdf = Grover.new(html, format: 'A4').to_pdf
    send_data pdf, filename: filename, type: "application/pdf"
  end


  private
  def certificate_params
    params.require(:certificate).permit(:name, :address, :zila, :lok_sabha, :state, :user_id)
  end
end
