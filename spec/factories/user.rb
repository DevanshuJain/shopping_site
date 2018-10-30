FactoryBot.define do 
  factory :user do 
    email { "djain@bestpeers.com" }
    password { "000000" }
    password_confirmation { "000000" }
    name { "dev" }
    mob_no { "0000000000" }
    role { "user" }
  end
end
