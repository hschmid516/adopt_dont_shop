class PetApp < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.pet_app_by_ids(pet_id, app_id)
    where(pet_id: pet_id, application_id: app_id).first
  end
end
