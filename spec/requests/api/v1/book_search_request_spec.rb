require "rails_helper"

RSpec.describe "Book Search API" do
  it " should return the books and weather for the city given"do
    location = "denver, co"
    quantity = 5
    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{Rails.application.credentials.mapquest[:key]}&location=#{location}")
        .to_return(
          status: 200,
          body: {
            results: [
              {
                locations: [
                  {
                    latLng: { lat: 39.7392, lng: -104.9903 }
                  }
                ]
              }
            ]
          }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?key=#{Rails.application.credentials.weather[:key]}&q=39.7392,-104.9903&days=5")
    .to_return(
      status: 200,
      body: {
        current: { last_updated: "2023-04-07 16:30", temp_f: 55.0, condition: { text: "Clear", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png" } },
        forecast: { forecastday: [{ date: "2023-04-07", day: { maxtemp_f: 60.0, mintemp_f: 45.0, condition: { text: "Clear", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png" } } }] }
      }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
    stub_request(:get, "https://openlibrary.org/search.json?q=#{location}")
        .to_return(status: 200, body: {
          docs: [
            {
              isbn: ["0762507845", "9780762507849"],
              title: "Denver, Co",
              publisher: ["Penguin Books"]
            },
            {
              isbn: ["9780883183663", "0883183668"],
              title: "Photovoltaic safety, Denver, CO, 1988",
              publisher: ["American Institute of Physics"]
            }
          ]
        }.to_json, headers: { 'Content-Type' => 'application/json' })
    
    get "/api/v1/book-search", params: { location: location, quantity: quantity }

    expect(response).to be_successful
    
    json = JSON.parse(response.body, symbolize_names: true)
binding.pry
    expect(json[:data][:attributes][:destination]).to eq("denver, co")
    expect(json[:data][:attributes][:forecast].to have_key(:summary))
    expect(json[:data][:attributes][:forecast].to have_key(:temperature))
    expect(json[:data][:attributes][:total_books_found]).to eq(5)
    expect(json[:data][:attributes][:books].size).to eq(5)
  end

  it "should return an error if the quantity is less than 1" do
    get "/api/v1/book-search", params: { location: "denver, co", quantity: 0 }

    expect(response).to have_http_status(400)
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:error]).to eq("Quantity must be greater than 0")
  end
end