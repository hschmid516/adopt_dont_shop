require 'rails_helper'

RSpec.describe 'new application page' do
  before(:each) do
    visit "/applications/new"
  end

  it 'fills out new application form' do
    fill_in 'Name', with: 'Henry Schmid'
    fill_in 'Street address', with: '12 Grimmauld Place'
    fill_in 'City', with: 'Littleton'
    fill_in 'State', with: 'CO'
    fill_in 'Zip', with: '80127'
    click_button 'Submit'

    expect(current_path).to eq("/applications/#{Application.last.id}")
    expect(page).to have_content(Application.last.name)
    expect(page).to have_content(Application.last.street_address)
    expect(page).to have_content(Application.last.city)
    expect(page).to have_content(Application.last.state)
    expect(page).to have_content(Application.last.zip)
    expect(page).to have_content(Application.last.description)
    expect(page).to have_content("Status: In Progress")
  end
end
