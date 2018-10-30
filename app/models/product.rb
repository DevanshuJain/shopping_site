class Product < ApplicationRecord
  has_many :carts, dependent: :destroy
  belongs_to :user
  mount_uploader :avatar, AvatarUploader
  
end
