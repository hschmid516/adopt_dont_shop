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

    visit "/admin/shelters"
  end

  it "shows shelters alphabetically" do
    expect(@shelter1.name).to appear_before(@shelter3.name)
    expect(@shelter3.name).to appear_before(@shelter2.name)
  end

  it 'shows shelters with pending applications' do
    expect(page).to have_content("Shelter's with Pending Applications")

    within("#shelter") do
      expect(page).to have_content(@shelter1.name)
      expect(page).to have_content(@shelter2.name)
      expect(page).to_not have_content(@shelter3.name)
    end
  end
end
