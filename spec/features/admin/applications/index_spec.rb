require 'rails_helper'

RSpec.describe 'admin app index page' do
  it 'shows application names' do
    app1 = create(:application)
    app2 = create(:application)
    app3 = create(:application)

    visit "/admin/applications"

    expect(page).to have_content(app1.name)
    expect(page).to have_content(app2.name)
    expect(page).to have_content(app3.name)
  end
end
