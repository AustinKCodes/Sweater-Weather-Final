require "rails_helper"

RSpec.describe "Munchies API" do
  describe "get /api/v1/munchies" do
    let(:location) { "Denver, CO" }
    let(:food) { "italian" }
    let(:destination_city) { "Denver, CO" }
    let(:forecast_data) { { summary: "Sunny", temperature: "75" } }
    let(:restaurant_data) { { name: "Tavernetta",
                            address: "1889 16th St, Denver, CO 80202",
                            rating: 4.5,
                            reviews: 767 } }
    before do
      allow(LocatorService).to receive(:get_location).and_return(location)
      allow(WeatherService).to receive(:get_weather).and_return(forecast_data)
      allow(SearchService).to receive(:find_restaurants).and_return(restaurant_data)
    end

    it "should return a successful response" do
      get "/api/v1/munchies?location=#{location}&food=#{food}"
      expect(response).to have_http_status(:success)
    end

    it "renders the correct response" do
      get "/api/v1/munchies?location=#{location}&food=#{food}"
      response1 = {
        data: {
          id: nil,
          attributes: {
            destination_city: location,
            forecast: {
              summary: forecast_data[:summary],
              temperature: forecast_data[:temp_f]
            },
            restaurant: {
              name: restaurant_data[:name],
              address: restaurant_data[:address],
              rating: restaurant_data[:rating],
              reviews: restaurant_data[:reviews]
            }
          }
        }
      }

      expect(JSON.parse(response.body)).to eq(response1)
    end
  end
end