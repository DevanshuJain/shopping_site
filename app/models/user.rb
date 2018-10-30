class User < ApplicationRecord
  after_create :assign_default_role
  
  has_many :orders, dependent: :destroy
  has_many :products, dependent: :destroy
  rolify
  has_one :address
  accepts_nested_attributes_for :address
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def assign_default_role
    add_role(:user) if self.role == "user"
    add_role(:seller) if self.role == "seller"
  end
end
