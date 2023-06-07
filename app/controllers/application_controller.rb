class ApplicationController < ActionController::Base
  before_action :set_logo
  
  def set_logo
    @app_logo = PhotoBuilder.app_logo
  end
end
