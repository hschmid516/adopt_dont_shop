require 'rails_helper'

RSpec.describe PetApp do
  it { should belong_to(:pet) }
  it { should belong_to(:application) }

  it 'finds pet apps by ids' do
  shelter = create(:shelter, name: 'Dogtown and Z-Boys')
  app = create(:application, status: 'Pending')
  pet = create(:pet, shelter: shelter)
  pet_app = PetApp.create!(application: app, pet: pet, status: 'Approved')

  expect(PetApp.pet_app_by_ids(pet.id, app.id)).to eq(pet_app)
  end

  it 'can update status' do
    shelter = create(:shelter, name: 'Dogtown and Z-Boys')
    app = create(:application, status: 'Pending')
    pet = create(:pet, shelter: shelter)
    pet_app = PetApp.create!(application: app, pet: pet, status: 'In Progress')

    pet_app.update_status!(true)

    expect(pet_app.status).to eq('Approved')

    pet_app.update_status!(false)

    expect(pet_app.status).to eq('Rejected')
  end
end
