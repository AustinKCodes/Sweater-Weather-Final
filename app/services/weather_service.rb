class WeatherService

  def self.conn
    Faraday.new(url: "http://api.weatherapi.com") do |faraday|
    end
  end
  def self.get_weather(lat, lng)
    response = conn.get("/v1/forecast.json") do |req|
      req.params["key"] = Rails.application.credentials.weather[:key]
      req.params["q"] = "#{lat},#{lng}"
      req.params["days"] = 5
    end

    json = JSON.parse(response.body, symbolize_names: true)

    {
      summary: json[:current][:condition][:text],
      temperature: "#{json[:current][:temp_f]} F"
    }
  end
end