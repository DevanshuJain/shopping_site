require 'rails_helper'

RSpec.describe "Sessions" do

  it "signs user in and out" do
    user = User.create!(email: "djain@bestpeers.com", password: "000000")
    
    sign_in user
    byebug
    # get authenticated_root_path
    # expect(controller.current_user).to eq(user)
    
    # sign_out user
    # get authenticated_root_path
    # expect(controller.current_user).to be_nil
  end

end