FactoryBot.define do
  factory :pet, class: Pet do
    name { Faker::TvShows::SouthPark.unique.character }
    adoptable { true }
    age { Faker::Number.between(from: 1, to: 18) }
    breed { Faker::Creature::Dog.breed  }
  end
end
