require 'rails_helper'

RSpec.describe "Admin::Shelters" do
  before :each do
    @shelter1 = create(:shelter, name: 'Dogtown and Z-Boys')
    @shelter2 = create(:shelter, name: 'White Claws')
    @shelter3 = create(:shelter, name: 'McGruff and Friends')
    @shelter4 = create(:shelter, name: 'A-A-Ron Pets')
    @pet1 = create(:pet, shelter: @shelter1)
    @pet2 = create(:pet, shelter: @shelter2)
    @pet3 = create(:pet, shelter: @shelter3)
    @pet4 = create(:pet, shelter: @shelter4)
    @app1 = create(:application, status: 'Pending')
    @app2 = create(:application, status: 'Pending')
    PetApp.create!(application: @app1, pet: @pet1)
    PetApp.create!(application: @app1, pet: @pet2)
    PetApp.create!(application: @app2, pet: @pet4)

    visit "/admin/shelters"
  end

  it "shows shelters alphabetically" do
    expect(@shelter1.name).to appear_before(@shelter3.name)
    expect(@shelter3.name).to appear_before(@shelter2.name)
  end

  it 'shows shelters with pending applications' do
    expect(page).to have_content("Shelter's with Pending Applications")

    within("#pending") do
      expect(page).to have_content(@shelter1.name)
      expect(page).to have_content(@shelter2.name)
      expect(page).to_not have_content(@shelter3.name)
    end
  end

  it 'sorts shelters alphabetically in pending section' do
    within("#pending") do
      expect(@shelter4.name).to appear_before(@shelter1.name)
      expect(@shelter1.name).to appear_before(@shelter2.name)
    end
  end

  it 'has links to each shelter' do
    click_link(@shelter1.name)

    expect(current_path).to eq("/shelters/#{@shelter1.id}")

    visit "/admin/shelters"

    click_link(@shelter2.name)

    expect(current_path).to eq("/shelters/#{@shelter2.id}")
  end
end

# When I visit the admin shelter index ('/admin/shelters')
# Then I see that every shelter name is a link
# When I click one of these links
# Then I am taken to that shelter's admin show page
