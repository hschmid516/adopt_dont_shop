FactoryBot.define do
  factory :pet, class: Pet do
    name { Faker::Games::Pokemon.unique.name}
    adoptable { true }
    age { Faker::Number.between(from: 1, to: 18) }
    breed { Faker::Creature::Dog.breed  }
  end
end
