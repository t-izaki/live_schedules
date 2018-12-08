FactoryBot.define do
  factory :schedule do
    date { '2018-12-08' }
    state { 1 }
    title { 'Big Event!!' }
    detail { "Today's event is big!!" }
  end
end
