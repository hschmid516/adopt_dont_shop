require 'rails_helper'

RSpec.describe 'applications' do
  before :each do
    @shelter = create(:shelter)
    @pet1 = create(:pet, shelter: @shelter)
    @pet2 = create(:pet, shelter: @shelter)
    @app = create(:application)
    PetApp.create!(application: @app, pet: @pet1)
    PetApp.create!(application: @app, pet: @pet2)
    visit "/applications/#{@app.id}"
  end

  it 'has attributes on show page' do
    expect(page).to have_content(@app.name)
    expect(page).to have_content(@app.street_address)
    expect(page).to have_content(@app.city)
    expect(page).to have_content(@app.state)
    expect(page).to have_content(@app.zip)
    expect(page).to have_content(@app.description)
    expect(page).to have_content(@app.status)
    expect(page).to have_content(@pet1.name)
    expect(page).to have_content(@pet2.name)
  end
end
