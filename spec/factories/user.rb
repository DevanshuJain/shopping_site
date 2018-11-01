require 'faker'

FactoryBot.define do 
  factory :user do
    email { Faker::Internet.email }
    password { "000000" }
    password_confirmation { "000000" }
    name { "dev" }
    mob_no { "0000000000" }
    # role { "user" }
  
    # factory :seller do
    #   after(:create) {|user| user.update_attributes(role: "seller")}
    # end

    # factory :custmer_user do
    #   after(:create) {|user| user.update_attributes(role: "user")}
    # end
 
    factory :seller do
      after(:create) {|user| user.add_role(:seller)}
    end

    factory :custmer_user do
      after(:create) {|user| user.add_role(:user)}
    end


  end
end

