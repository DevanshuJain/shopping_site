require "rails_helper"

RSpec.feature "user management", :type => :feature do
  scenario "User creates" do
    visit "/users/sign_in"
    fill_in "Email", :with => "djain@bestpeers.com"
    fill_in "Password", :with => "000000"     
    click_button "Log in"
    expect(page).to have_text("Signed in successfully.")
    visit "/seller_product"
    expect("seller_product").present?
    have_link("add_product", :href => "/products/new")
    p=Product.count
    expect(p).to eq(Product.count)
    q=Product.last
    have_link("Show", :href => "/products/#{q}")
    expect("title").present?
    have_link("edit", :href => "/products/#{q}/edit")
    expect("edit_page").present?
    have_link("Destroy", :href => "/products/#{q}")
    expect("seller_product").present?
  end
end