require "rails_helper"

RSpec.describe Order, :type => :model do
  context "order_assosiation" do
    it { should have_many(:carts).dependent(:destroy) }
    it { should belong_to(:user) }
  end
end
