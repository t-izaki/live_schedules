FactoryBot.define do
  factory :admin do
    sequence(:email) { |n| "address#{n}@admin.example" }
    password { 'asdfasdf' }
  end
end
