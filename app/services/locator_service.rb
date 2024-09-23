class LocatorService
  def self.conn
    Faraday.new("http://www.mapquestapi.com")
  end

  def self.get_location(location)
    response = conn.get("/geocoding/v1/address") do |req|
      req.params["key"] = Rails.application.credentials.mapquest[:key]
      req.params["location"] = location
    end
    data = JSON.parse(response.body, symbolize_names: true)
    lat_lng = data[:results].first[:locations].first[:latLng]
    { lat: lat_lng[:lat], lng: lat_lng[:lng] }
  end
end