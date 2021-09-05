class Application < ApplicationRecord
  validates_presence_of :name,
                        :street_address,
                        :city,
                        :state,
                        :zip

  has_many :pet_apps, dependent: :destroy
  has_many :pets, through: :pet_apps
end
