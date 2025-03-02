class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end

  def self.order_by_name
    find_by_sql('SELECT * FROM shelters ORDER BY name')
  end

  def self.pending_apps_ordered
    joins(pets: :applications).where('applications.status = ? ', 'Pending').order(:name)
  end

  def find_name
    name_info = Shelter.find_by_sql ['SELECT name FROM shelters WHERE id = ?', self.id]
      name_info.first[:name]
  end

  def find_city
    city_info = Shelter.find_by_sql ['SELECT city FROM shelters WHERE id = ?', self.id]
      city_info.first[:city]
  end
end
