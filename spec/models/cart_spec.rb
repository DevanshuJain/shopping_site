require "rails_helper"

RSpec.describe Cart, :type => :model do
  context "cart_assosiation" do
    it { should belong_to(:order) }
  end
end
