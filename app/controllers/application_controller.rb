class ApplicationController < ActionController::Base
  before_action :check_user

  def check_user
    unless current_user
      if request.path != root_path && request.path != sign_in_path
        redirect_to root_path, flash: { notice: "First login please" }
      end
    end
  end

  def current_user
    current_user = Rails.application.config.current_user
  end
end
