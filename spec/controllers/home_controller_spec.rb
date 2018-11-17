require 'rails_helper'

RSpec.describe Api::V1::HomeController do
  describe "GET #index" do
    it "returns a 200 success response" do
      get :index

      expect(response).to have_http_status(200)
    end
  end
end
