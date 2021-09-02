FactoryBot.define do
  factory :shelter, class: Shelter do
    name { Faker::Company.name }
    foster_program  { true }
    city { Faker::Address.city }
    rank { Faker::Number.between(from: 1, to: 100) }
  end
end
