FactoryBot.define do
  factory :schedule do
    date { '2018-12-08' }
    state { 1 }
    title { Faker::Lorem.word }
    detail { Faker::Lorem.sentence }

    trait :undecided do
      state { Schedule.states['undecided'] }
    end

    trait :open do
      state { Schedule.states['open'] }
    end

    trait :closed do
      state { Schedule.states['closed'] }
    end

    trait :no_title do
      title { '' }
    end

    trait :no_detail do
      detail { '' }
    end

    trait :with_performer do
      after(:build) do |schedule|
        schedule.performers << build(:performer)
      end
    end

    factory :simple_schedule, traits: %i[no_title no_detail]
    factory :simple_undecided_schedule, traits: %i[undecided no_title no_detail]
    factory :simple_open_schedule, traits: %i[open no_title no_detail]
    factory :simple_closed_schedule, traits: %i[closed no_title no_detail]
  end
end
