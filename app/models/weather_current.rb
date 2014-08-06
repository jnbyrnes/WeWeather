class WeatherCurrent
  include Mongoid::Document
  include Mongoid::Timestamps::Updated
  include Mongoid::Timestamps::Created
  field :zip_code, type: Integer
  field :location_name, type: String
  field :temp, type: String
  field :conditions, type: String
  field :forecast_image, type: String
  
end