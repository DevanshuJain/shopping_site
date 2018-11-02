require "rails_helper"

RSpec.feature "user management", :type => :feature do
  scenario "User creates" do
    visit "/users/sign_in"
    fill_in "Email", :with => "djain@bestpeers.com"
    fill_in "Password", :with => "000000"
         
    click_button "Log in"
    expect(page).to have_text("Signed in successfully.")
  end
end