require "rails_helper"
require 'spec_helper'
require 'devise'

RSpec.describe ProductsController, :type => :controller do
  before(:all) do
    user = FactoryBot.create(:seller)
    sign_in user
  end

  describe "product/index" do
    it "product#index" do
      get :index
      expect(response.status).to eq(200)
      # expect(response.content_type).to eq "text/html"
      # respond_to.should redirect_to '/users/sign_in'
      # sign_in user
    end
  end
end