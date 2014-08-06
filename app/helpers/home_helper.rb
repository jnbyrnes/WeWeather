require "net/http"
require "uri"

module HomeHelper
  def retrieve_current(zip_code)
    # http://api.wunderground.com/api/464bac5295d5cdf6/conditions/q/10011.json
    uri = URI.parse("#{WeWeather::Application.config.BASE_API_URL}/#{WeWeather::Application.config.API_KEY}/conditions/q/#{zip_code}.json")
    logger.debug(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
 
    response = http.request(request)
 
    if response.code == "200"
      return response
    else
      return nil
    end
  end
  
  def retrieve_hourly
    # http://api.wunderground.com/api/464bac5295d5cdf6/hourly/q/10011.json
  end
  
  def retrieve_three_day(zip_code)
    # http://api.wunderground.com/api/464bac5295d5cdf6/forecast/q/10011.json
    uri = URI.parse("#{WeWeather::Application.config.BASE_API_URL}/#{WeWeather::Application.config.API_KEY}/forecast/q/#{zip_code}.json")
    logger.debug(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
 
    response = http.request(request)
 
    if response.code == "200"
      return response
    else
      return nil
    end
  end
  
  def parse_current(response, zip_code)
    if (response)
      parsed_json = ActiveSupport::JSON.decode(response.body)
      current_observation = parsed_json['current_observation']
      
      current_location = current_observation['display_location']['full']
      current_temp = current_observation['temperature_string']
      current_conditions = current_observation['weather']
      current_url = current_observation['icon_url']
      
      current_weather = WeatherCurrent.create!(zip_code: zip_code, location_name: current_location, temp: current_temp, conditions: current_conditions, forecast_image: current_url)
      return current_weather
    else
      return nil
    end
  end
  
  def parse_hourly
    
  end
  
  def parse_three_day(response, zip_code)
    if (response)
      parsed_json = ActiveSupport::JSON.decode(response.body)
      forecast_array = parsed_json['forecast']['simpleforecast']['forecastday']
      
      days=[]
      highs=[]
      lows=[]
      conditions=[]
      forecast_images=[]
      forecast_array.each do |f|
        break if (days.count>=3)
        days.push(f['date']['weekday'])
        high_f = f['high']['fahrenheit']
        high_c = f['high']['celsius']
        highs.push("#{high_f} F (#{high_c} C)")
        low_f = f['low']['fahrenheit']
        low_c = f['low']['celsius']
        lows.push("#{low_f} F (#{low_c} C)")
        conditions.push(f['conditions'])
        forecast_images.push(f['icon_url'])
      end  
      
      current_weather = WeatherThreeDay.create!(zip_code: zip_code, days: days, highs: highs, lows: lows, conditions: conditions, forecast_images: forecast_images)
      return current_weather
    else
      return nil
    end
  end
  
  def retrieve_recent_current(zip_code)
    current_weathers = WeatherCurrent.where(:zip_code => zip_code, :created_at.gte => DateTime.now.advance(:hours => -1))
    if (current_weathers and current_weathers.first)
      return current_weathers.first
    else
      return nil
    end
  end
  
  def retrieve_recent_three_day(zip_code)
    three_day_weathers = WeatherThreeDay.where(:zip_code => zip_code, :created_at.gte => DateTime.now.advance(:hours => -1))
    if (three_day_weathers and three_day_weathers.first)
      return three_day_weathers.first
    else
      return nil
    end
  end
  
end
