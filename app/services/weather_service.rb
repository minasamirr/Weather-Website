# app/services/weather_service.rb
require 'httparty'

class WeatherService
  BASE_URL = 'https://api.openweathermap.org/data/2.5/weather'
  API_KEY = 'YOUR_OPENWEATHERMAP_API_KEY' # Replace with your OpenWeatherMap API key

  def self.fetch_weather(city)
    response = HTTParty.get(BASE_URL, query: { q: city, appid: API_KEY, units: 'metric' })
    response.parsed_response
  end
end
