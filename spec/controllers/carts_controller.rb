require "rails_helper"
require 'spec_helper'
require 'devise'
require 'database_cleaner'

RSpec.describe CartsController, :type => :controller do
  context 'user' do
    before(:all) do
      @user = FactoryBot.create(:user)
      sign_in @user
    end

    describe "cart/index" do
      it "cart#index" do
        get :index
        expect(response.status).to eq(302)
        @product=Product.last
        get :add_to_cart, params: {"id" => @product.id}
        expect(response.status).to eq(302)
      end
    end
  end
end