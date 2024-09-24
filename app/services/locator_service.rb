class LocatorService
  def self.conn
    Faraday.new("http://www.mapquestapi.com")
  end

  def self.get_location(location)
    response = conn.get("/geocoding/v1/address") do |req|
      req.params["key"] = Rails.application.credentials.mapquest[:key]
      req.params["location"] = location
    end
    locations = JSON.parse(response.body, symbolize_names: true)
    results = locations[:results].first[:locations].first[:latLng]
  end
end