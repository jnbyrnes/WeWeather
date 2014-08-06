class HomeController < ApplicationController
  include HomeHelper
  
  before_filter :current_zip, only: [:index, :hourly, :three_day]
  
  def index
    begin
      @current_weather = retrieve_recent_current(@zip_code)
      unless (@current_weather)
        api_response = retrieve_current(@zip_code)
        @current_weather = parse_current(api_response, @zip_code)
      end
    rescue => e
      @current_weather = nil
      logger.debug(e.message)
    end
    render :index
  end
  
  def hourly
  end
  
  def three_day
    begin
      @three_day_weather = retrieve_recent_three_day(@zip_code)
      unless (@three_day_weather)
        api_response = retrieve_three_day(@zip_code)
        @three_day_weather = parse_three_day(api_response, @zip_code)
      end
    rescue => e
      @three_day_weather = nil
      logger.debug(e.message)
    end
    render :three_day
  end
  
  def update_zip
    begin
      raise "zip_code not defined" unless params[:zip]
      @zip_code = params[:zip]
      session[:current_zip_code] = @zip_code
      @current_weather = retrieve_recent_current(@zip_code)
      unless (@current_weather)
        api_response = retrieve_current(@zip_code)
        @current_weather = parse_current(api_response, @zip_code)
      end
    rescue => e
      @current_weather = nil
      logger.debug(e.message)
    end
    render :index
  end
end
