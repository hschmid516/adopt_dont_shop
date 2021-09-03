require 'rails_helper'

RSpec.describe 'applications' do
  describe 'show application' do
    before :each do
      @shelter = create(:shelter)
      @pet1 = create(:pet, shelter: @shelter)
      @pet2 = create(:pet, shelter: @shelter)
      @pet3 = create(:pet, shelter: @shelter)
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

    it "links to each pet's show page" do
      within("#app-#{@pet1.id}") do
        click_link("#{@pet1.name}")

        expect(current_path).to eq("/pets/#{@pet1.id}")
      end

      visit "/applications/#{@app.id}"

      within("#app-#{@pet2.id}") do
        click_link("#{@pet2.name}")

        expect(current_path).to eq("/pets/#{@pet2.id}")
      end
    end
  end

  describe 'show application' do
    before :each do
      @shelter = create(:shelter)
      @pet1 = create(:pet, shelter: @shelter)
      @pet2 = create(:pet, shelter: @shelter)
      @pet3 = create(:pet, shelter: @shelter)
      @app = create(:application)
      visit "/applications/#{@app.id}"
    end

    it 'can search for pets to add' do
      expect(page).to have_content('Add a Pet to this Application')

      fill_in 'Search for Pet by Name:', with: "#{@pet1.name}"
      click_button('Search')

      expect(current_path).to eq("/applications/#{@app.id}")
      expect(page).to have_content("#{@pet1.name}")
      expect(page).to_not have_content("#{@pet3.name}")
    end

    it 'can add seached pets to app' do
      fill_in 'Search for Pet by Name:', with: "#{@pet1.name}"
      click_button('Search')

      within("#pet-#{@pet1.id}") do
        click_button('Add Pet to Application')
      end

      within("#app-#{@pet1.id}") do
        expect(page).to have_content(@pet1.name)
      end
    end

    it 'can add description and submit app' do
      expect(page).to_not have_content('Why Would You be a Good Pet Owner?')

      fill_in 'Search for Pet by Name:', with: "#{@pet1.name}"
      click_button('Search')
      within("#pet-#{@pet1.id}") do
        click_button('Add Pet to Application')
      end

      expect(page).to have_content('Why Would You be a Good Pet Owner?')

      fill_in :description, with: "I love dogs"
      click_button('Submit Application')

      expect(current_path).to eq("/applications/#{@app.id}")
      expect(page).to have_content('Pending')
      expect(page).to have_content(@pet1.name)
      expect(page).to_not have_content('Add a Pet to this Application')
      expect(page).to_not have_content('Add Pet to Application')
    end

    it 'has no submit if no pets' do
      expect(@app.pets).to eq([])
      expect(page).to_not have_content("Why Would You be a Good Pet Owner?")
      expect(page).to_not have_content("Submit Application")
    end

    it 'can search for partial matches' do
      fill_in 'Search for Pet by Name:', with: "#{@pet1.name[0..2]}"
      click_button('Search')

      within("#pet-#{@pet1.id}") do
        expect(page).to have_content(@pet1.name)
      end
    end

    it 'can search for case insensitive matches' do
      fill_in 'Search for Pet by Name:', with: "#{@pet1.name.downcase}"
      click_button('Search')

      within("#pet-#{@pet1.id}") do
        expect(page).to have_content(@pet1.name)
      end
    end
  end
end
