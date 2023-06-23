class ApplicationController < ActionController::Base


  def current_user
    current_user = Rails.application.config.current_user
  end
end
