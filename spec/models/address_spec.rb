require "rails_helper"

RSpec.describe Address, :type => :model do
  context "address_assosiation" do
    it { should belong_to(:user) }
  end
end
