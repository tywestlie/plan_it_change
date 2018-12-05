require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do

  describe "Get #index" do
    it "retreives all posts by location" do
      get :index
    end
  end

end
