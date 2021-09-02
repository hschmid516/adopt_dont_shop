class Application < ApplicationRecord
  has_many :pet_apps, dependent: :delete_all
  has_many :pets, through: :pet_apps
end
