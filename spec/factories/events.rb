FactoryBot.define do
  factory :event do
    city              { "Denver" }
    state             { "CO" }
    information       { Faker::HitchhikersGuideToTheGalaxy.quote }
    start_time        { Faker::Time.between(10.days.ago, 5.days.ago).to_datetime }
    end_time          { Faker::Time.between(4.days.ago, 1.days.ago).to_datetime }
    event_name        { Faker::HitchhikersGuideToTheGalaxy.starship }
    factory :event_with_owner do
      transient do
        owner         { Faker::Internet.email }
      end
    end

  end
end
