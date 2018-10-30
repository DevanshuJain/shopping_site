require "rails_helper"

RSpec.describe ProductsController, :type => :controller do
  it "assigns product" do
    user = FactoryBot.create(:user)
    sign_in user
    byebug
    get :index
  end
end