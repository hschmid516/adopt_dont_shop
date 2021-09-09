require 'rails_helper'

RSpec.describe "admin shelters show page" do
  before :each do
    @shelter1 = create(:shelter)
    visit "/admin/shelters/#{@shelter1.id}"
  end

  it 'shows the shelters name and full address' do
    expect(page).to have_content(@shelter1.name)
    expect(page).to have_content(@shelter1.city)
  end
end
