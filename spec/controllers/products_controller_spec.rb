require "rails_helper"
require 'spec_helper'
require 'devise'
require 'database_cleaner'

RSpec.describe ProductsController, :type => :controller do
  describe 'user' do
    before(:all) do
      @user = FactoryBot.create(:user)
      sign_in @user
    end  
    it "product#index" do
      expect(response.status).to eq(200)
    end 
  end

  context 'seller' do
    before(:all) do
      @seller = FactoryBot.create(:seller)
      sign_in @seller
    end
    it "seller#product" do
      sign_in @seller
      get :seller_product
      expect(response.status).to eq(200)
      post :create, params: {product: {"title" => "mswer", "description"=>"juisss", "price"=> "147", "available_quantity"=>"14" }}
      expect(response.status).to eq(302)
      @product=Product.last
      get :product_status
      expect(response.status).to eq(200)
      get :show, params: {"id" => @product.id}
      expect(response.status).to eq(200)
      get :edit, params: {"id" => @product.id}
      expect(response.status).to eq(200)
      put :update, params: {product: {"title" => "mswhyuer", "description"=>"juisss", "price"=> "147", "available_quantity"=>"23"},"id" => @product.id}
      expect(response.status).to eq(302)
      delete :destroy, params: {"id" => @product}
      expect(response.status).to eq(302)
    end    
  end
end