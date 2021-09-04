require 'rails_helper'

RSpec.describe "Admin::Shelters" do
  before :each do
    @shelter1 = create(:shelter, name: 'Dogtown and Z-Boys')
    @shelter2 = create(:shelter, name: 'White Claws')
    @shelter3 = create(:shelter, name: 'McGruff and Friends')
    @pet1 = create(:pet, shelter: @shelter1)
    @pet2 = create(:pet, shelter: @shelter2)
    @pet3 = create(:pet, shelter: @shelter3)
    @app1 = create(:application, status: 'Pending')
    @app2 = create(:application, status: 'Pending')
    @app2 = create(:application)
    PetApp.create!(application: @app1, pet: @pet1)
    PetApp.create!(application: @app1, pet: @pet2)
    visit "/admin/applications/#{@app1.id}"
  end

  it 'has button to approve each pet' do
    within("#app-#{@pet1.id}") do
      click_button('Approve')

      expect(current_path).to eq("/admin/applications/#{@app1.id}")
      save_and_open_page
      expect(page).to_not have_button('Approve')
      expect(page).to have_content('Approved')
    end

    within("#app-#{@pet2.id}") do
      expect(page).to have_button('Approve')
      expect(page).to_not have_content('Approved')
    end
  end
end


# save_and_open_page
