class Application < ApplicationRecord
  validates_presence_of :name,
                        :street_address,
                        :city,
                        :state,
                        :zip

  has_many :pet_apps, dependent: :destroy
  has_many :pets, through: :pet_apps

  def pets_approved?
    pet_app = PetApp.where(application_id: id)
    pet_app.count == pet_app.where(status: 'Approved').count && pet_app.count != 0
  end

  def pets_rejected?
    pet_app = PetApp.where(application_id: id)
    (pet_app.count == pet_app.where(status: ['Approved', 'Rejected']).count &&
      pet_app.where(status: 'Rejected').exists? == true) && pet_app.count != 0
  end
end
