require "rails_helper"

RSpec.feature "user management", :type => :feature do
  scenario "User creates" do
    visit "/users/sign_up"

    fill_in "Name", :with => "My Widget"
    fill_in "Mob no", :with => "0000000000"
    fill_in "Email", :with => "djain@bestpeers.com"
    fill_in "Password", :with => "000000"
    fill_in "Password confirmation", :with => "000000"
    fill_in "City", :with => "indore"
    fill_in "State", :with => "m.p."
    fill_in "Pin no", :with => "452010"
    byebug
    # fill_in "role", :with => "452010"
    
    # choose('role', visible: false)

    click_button "Sign up"
    expect(page).to have_text("Welcome! You have signed up successfully.")
  end
end