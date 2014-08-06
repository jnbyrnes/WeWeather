class WeatherHourly
  include Mongoid::Document
  include Mongoid::Timestamps::Updated
  include Mongoid::Timestamps::Created
  field :zip_code, type: Integer
  field :days, type: Array
  field :hours, type: Array
  field :temps, type: Array
  field :conditions, type: Array
  field :forecast_images, type: Array
  
end