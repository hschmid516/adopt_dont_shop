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

    PetApp.create!(application: app, pet: pet1, status: 'Approved')
    PetApp.create!(application: app, pet: pet2, status: 'Approved')
    pet_app = PetApp.create!(application: app, pet: pet3)

    expect(app.pets_approved?).to eq(false)

    pet_app.update_status!('Approved')

    expect(app.pets_approved?).to eq(true)
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

  it 'can update status to accepted' do
    shelter = create(:shelter, name: 'Dogtown and Z-Boys')
    app = create(:application, status: 'Pending')
    pet1 = create(:pet, shelter: shelter)
    pet2 = create(:pet, shelter: shelter)
    pet3 = create(:pet, shelter: shelter)

    PetApp.create!(application: app, pet: pet1, status: 'Approved')
    PetApp.create!(application: app, pet: pet2, status: 'Approved')
    PetApp.create!(application: app, pet: pet3, status: 'Approved')

    app.update_status!

    expect(app.status).to eq('Approved')
  end

  it 'can update status to rejected' do
    shelter = create(:shelter, name: 'Dogtown and Z-Boys')
    app = create(:application, status: 'Pending')
    pet1 = create(:pet, shelter: shelter)
    pet2 = create(:pet, shelter: shelter)
    pet3 = create(:pet, shelter: shelter)

    PetApp.create!(application: app, pet: pet1, status: 'Approved')
    PetApp.create!(application: app, pet: pet2, status: 'Approved')
    PetApp.create!(application: app, pet: pet3, status: 'Rejected')

    app.update_status!

    expect(app.status).to eq('Rejected')
  end

  it 'can update pets to not adoptable' do
    shelter = create(:shelter, name: 'Dogtown and Z-Boys')
    app = create(:application, status: 'Pending')
    pet1 = create(:pet, shelter: shelter)
    pet2 = create(:pet, shelter: shelter)

    app.adopt_pets!

    expect(pet1.adoptable).to eq(true)
    expect(pet2.adoptable).to eq(true)
  end
end
