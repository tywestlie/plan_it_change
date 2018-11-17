require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  include APIHelper
  let(:user) { create(:user) }

  describe "Get #index" do
    it "should return a 401 due to an unauthorized user" do
      get :index

      expect(response).to have_http_status(401)
    end
    
    it "should return a 200 if a user is authorized" do
      authenticated_header(request, user)
      get :index

      expect(response).to have_http_status(200)
    end
  end

  describe "Post #create" do
    it "should return a 200 when creating a new user" do
      post :create, params: { user: { first_name: 'Jim', last_name: 'Smith', email: 'Jim@example.com', city: 'Denver', state: 'CO', password: 'password', password_confirmation: 'password', role: 'user' } }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(result[:user]).to eq("jim@example.com")
      expect(result[:created]).to eq("Yes")
    end

    it "should return a 409 if the user already exists" do
      user = User.create!(first_name: 'Jim', last_name: 'Smith', email: 'Jim@example.com', city: 'Denver', state: 'CO', password: 'password', password_confirmation: 'password', role: 'user')

      post :create, params: { user: { first_name: 'Jim', last_name: 'Smith', email: 'Jim@example.com', city: 'Denver', state: 'CO', password: 'password', password_confirmation: 'password', role: 'user' } }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(409)
      expect(result[:user]).to eq("#{user.email.downcase}")
      expect(result[:created]).to eq("No")
      expect(result[:error]).to eq("User may already exist.")
    end
  end

  describe "Patch #update" do
    it 'should return a 200 on a successful update' do
      authenticated_header(request, user)
      patch :update, params: { use_route: "/api/v1/user_update/#{user.id}", id: user.id, user: { first_name: "Joseph", last_name: "Contral"} }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(result[:user]).to eq("#{user.email}")
      expect(result[:updated]).to eq("Yes")
    end
  end

end
