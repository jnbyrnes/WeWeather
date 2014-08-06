class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def current_zip
    @zip_code = session[:current_zip_code]
  end
end
