require "rails_helper"

RSpec.describe User, :type => :model do
  context "user_assosiation" do
    it { should have_many(:orders).dependent(:destroy) }
    it { should have_many(:products).dependent(:destroy) }
    it { should have_one(:address) }
    it { should accept_nested_attributes_for(:address) }
  end
end