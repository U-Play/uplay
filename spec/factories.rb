FactoryGirl.define do

  factory :authorization do
    first_name 'John'
    last_name 'Doe'
    uid '12345'
    token '54321'
    email 'email@dummy.com'

    factory :facebook_authorization do
      provider :facebook
    end
  end

  factory :user do
    first_name 'John'
    last_name 'Doe'
    email 'email@dummy.com'
  end

end
