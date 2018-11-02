require "rails_helper"

RSpec.feature "user management", :type => :feature do
  scenario "User creates" do
    visit "/users/sign_in"
    fill_in "Email", :with => "djain@bestpeers.com"
    fill_in "Password", :with => "000000"     
    click_button "Log in"
    expect(page).to have_text("Signed in successfully.")
    visit root_path
    expect("Products_index").present?
    p=Product.count
    expect(p).to eq(Product.count)
  end
end

RSpec.feature "user management", :type => :feature do
  scenario "User show" do
    visit "/users/sign_in"
    fill_in "Email", :with => "djain@bestpeers.com"
    fill_in "Password", :with => "000000"     
    click_button "Log in"
    expect(page).to have_text("Signed in successfully.")
    visit root_path
    expect("Products_index").present?
    p=Product.count
    expect(p).to eq(Product.count)
    a=Product.last
    have_link("add_to_cart", :href => "/products/#{a}/add_to_cart")
  end
end