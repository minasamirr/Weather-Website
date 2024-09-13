class WeatherController < ApplicationController
  require "httparty"

  def index
  end

  def get_weather
    country = params[:country]
    city = params[:city]
    url = get_api_url(country, city)

    response = HTTParty.get(url)
    if response.success?
      session[:weather_data] = response.parsed_response
      session[:advice] = generate_advice(session[:weather_data])
    else
      session[:weather_data] = {}
      session[:error] = "Could not retrieve weather data. Please check the city name."
    end

    redirect_to result_path
  end

  def result
    @weather_data = session[:weather_data]
    @advice = session[:advice]
    @error = session[:error]
  end

  private
  
  def get_api_url(country, city)
    api_key = "2ab7b3e2e5bf1a9cb80837b9e90fad3e"
    url = "https://api.openweathermap.org/data/2.5/weather?q=#{country},#{city}&appid=#{api_key}&units=metric"
  end

  def generate_advice(weather_data)
    temperature = weather_data["main"]["temp"]
    weather_condition = weather_data["weather"][0]["main"].downcase

    if weather_condition.include?("rain") || weather_condition.include?("drizzle")
      "It's raining, take an umbrella!"
    elsif temperature > 30
      "It's too hot outside, better to stay indoors."
    elsif temperature < 5
      "It's freezing outside, wear warm clothes or stay inside."
    elsif temperature.between?(15, 25) && weather_condition == "clear"
      "The weather is perfect for a run!"
    else
      "Weather looks moderate, enjoy your day!"
    end
  end
end
