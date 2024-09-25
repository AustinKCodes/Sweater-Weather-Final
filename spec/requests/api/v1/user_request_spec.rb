require "rails_helper"

RSpec.describe "Users API" do
  it "should create a user when given proper params" do
    post "/api/v1/users", params: {
      user: {
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password"
      }
    }

    expect(response).to have_http_status(201)
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:data][:attributes][:email]).to eq("whatever@example.com")
    expect(json[:data][:attributes][:api_key]).to be_present
  end

  it "should return an error if the passwords are different" do
    post "/api/v1/users", params: {
      user: {
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password1"
      }
    }

    expect(response).to have_http_status(400)
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:error][:message]).to eq("Validation failed: Password confirmation doesn't match Password")
  end
end