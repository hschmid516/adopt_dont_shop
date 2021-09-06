require 'rails_helper'

RSpec.describe Application do
  it { should have_many(:pet_apps) }
  it { should have_many(:pets).through(:pet_apps) }

  it 'checks if all pets are approved' do
    shelter = create(:shelter, name: 'Dogtown and Z-Boys')
    app = create(:application, status: 'Pending')
    pet1 = create(:pet, shelter: shelter)
    pet2 = create(:pet, shelter: shelter)
    pet3 = create(:pet, shelter: shelter)

    expect(app.pets_approved?).to eq(false)

    PetApp.create!(application: app, pet: pet1, status: 'Approved')
    PetApp.create!(application: app, pet: pet2, status: 'Approved')

    expect(app.pets_approved?).to eq(true)

    PetApp.create!(application: app, pet: pet3, status: 'Rejected')

    expect(app.pets_approved?).to eq(false)
  end

  it 'checks if > 1 pets rejected and all others approved' do
    shelter = create(:shelter, name: 'Dogtown and Z-Boys')
    app = create(:application, status: 'Pending')
    pet1 = create(:pet, shelter: shelter)
    pet2 = create(:pet, shelter: shelter)
    pet3 = create(:pet, shelter: shelter)

    expect(app.pets_rejected?).to eq(false)

    PetApp.create!(application: app, pet: pet1, status: 'Approved')
    PetApp.create!(application: app, pet: pet2, status: 'Approved')

    expect(app.pets_rejected?).to eq(false)

    PetApp.create!(application: app, pet: pet3, status: 'Rejected')

    expect(app.pets_rejected?).to eq(true)
  end
end
