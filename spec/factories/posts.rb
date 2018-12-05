FactoryBot.define do
  factory :post do
    user        { Faker::Name.unique.first_name }
    body        { Faker::HitchhikersGuideToTheGalaxy.quote }
  end
end
