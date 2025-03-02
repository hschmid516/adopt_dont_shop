FactoryBot.define do
  factory :application, class: Application do
    name { Faker::TvShows::RickAndMorty.character }
    street_address  { Faker::Address.unique.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip_code }
    description { Faker::TvShows::RickAndMorty.unique.quote }
    status { "In Progress" }
  end
end
