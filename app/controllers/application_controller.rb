class ApplicationController < ActionController::Base
  before_action :check_user
  # rescue_from Exception, with: :render_500


  def not_found_method
    render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
  end

  # def render_500(exception)
  #   logger.error(exception.message)
  #   render template: 'error/500', status: :internal_server_error
  # end

  def check_user
    unless current_user
      if request.path != root_path && request.path != sign_in_path
        redirect_to root_path, flash: { notice: "Please login first" }
      end
    end
  end

  def current_user
    User.where(id:session[:user_id]).first
  end
end
