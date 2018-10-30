require "rails_helper"

RSpec.describe Product, :type => :model do
  context "product_assosiation" do
    it { should have_many(:carts).dependent(:destroy) }
    it { should belong_to(:user) }
  end
end