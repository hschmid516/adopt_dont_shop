class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :pet_apps, dependent: :destroy
  has_many :applications, through: :pet_apps

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def pet_app_status(app_id)
    PetApp.where(pet_id: id, application_id: app_id).first.status
  end
end
