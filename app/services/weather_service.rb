class WeatherService

  def self.conn
    Faraday.new(url: "http://api.weatherapi.com") do |faraday|
    end
  end
  def self.get_weather(location)
    response = conn.get("/v1/forecast.json") do |req|
      req.params["key"] = Rails.application.credentials.weather[:key]
      req.params["q"] = "#{;location[:lat]},#{location[:lng]}"
      req.params["days"] = 5
    end
    weather_data = JSON.parse(response.body, symbolize_names: true)
    
  end
end