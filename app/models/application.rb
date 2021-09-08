class Application < ApplicationRecord
  validates_presence_of :name,
                        :street_address,
                        :city,
                        :state,
                        :zip

  has_many :pet_apps, dependent: :destroy
  has_many :pets, through: :pet_apps

  def pets_approved?
    !PetApp.where(application_id: id, status: [nil, 'Rejected']).exists?
  end

  def pets_rejected?
    PetApp.where(application_id: id).where(status: 'Rejected').exists? &&
      !pet_apps.where(status: nil).exists?
  end

  def update_status!
    if pets_approved?
      update(status: 'Approved')
    elsif pets_rejected?
      update(status: 'Rejected')
    end
  end

  def adopt_pets!
    pets.update_all(adoptable: false)
  end
end
