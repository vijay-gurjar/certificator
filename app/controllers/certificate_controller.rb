class CertificateController < ApplicationController
  def index

    if (current_user)
      @user = current_user
      @certificate = Certificate.where(user_id: current_user.id).first
      @downloaded_c = Download.where(user_id: current_user.id)
      puts current_user.id
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
      @certificate = Certificate.where(certificate_params).first_or_create!

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
    @user = User.find(params[:u])
    @certificate = Certificate.find_by(id: params[:c])
    if @user.present? && @certificate.present?
      Download.where(user_id: @user.id, certificate_id: @certificate.id).first_or_create!
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

  def render_pdf(html, filename:)
    pdf = Grover.new(html, format: 'A4').to_pdf
    send_data pdf, filename: filename, type: "application/pdf"
  end


  private
  def certificate_params
    params.require(:certificate).permit(:name, :address, :zila, :lok_sabha, :state, :user_id)
  end
end
