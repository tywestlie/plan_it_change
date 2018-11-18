FactoryBot.define do 
  factory :user do
    first_name        { Faker::Name.unique.first_name }
    last_name         { Faker::Food.ingredient }
    email             { Faker::Internet.email }
    city              { "Denver" }
    state             { "CO" }
    password          { "password" }
    password_confirmation { "password" }
  end
end
