class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :pet_apps, dependent: :delete_all
  has_many :applications, through: :pet_apps

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.pets_in_app(app_id)
    joins(:applications).joins(:pet_apps).where(pet_apps: {application_id: app_id}).distinct
  end
end
