FactoryBot.define do
  factory :performer do
    name { Faker::Name.unique.name }
    introduction { Faker::Lorem.paragraph }
    instrument

    trait :blank_introduction do
      introduction { '' }
    end
  end
end
