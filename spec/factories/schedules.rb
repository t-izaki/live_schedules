FactoryBot.define do
  factory :schedule do
    date { '2018-12-08' }
    state { 1 }
    title { 'Big Event!!' }
    detail { "Today's event is big!!" }

    trait :no_title do
      title { '' }
    end

    trait :no_detail do
      detail { '' }
    end

    factory :simple_schedule, traits: %i[no_title no_detail]
  end
end
