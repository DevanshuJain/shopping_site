class Order < ApplicationRecord
  has_many :carts, dependent: :destroy
  belongs_to :user
end
