require 'rails_helper'

RSpec.describe "Admin::Applications" do
  describe 'approve and reject pets' do
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
      PetApp.create!(application: @app2, pet: @pet1)
      PetApp.create!(application: @app2, pet: @pet2)
      visit "/admin/applications/#{@app1.id}"
    end

    it 'can approve pets' do
      within("#app-#{@pet1.id}") do
        click_button('Approve')

        expect(current_path).to eq("/admin/applications/#{@app1.id}")
        expect(page).to_not have_button('Approve')
        expect(page).to have_content('Approved')
      end

      within("#app-#{@pet2.id}") do
        expect(page).to have_button('Approve')
        expect(page).to_not have_content('Approved')
      end
    end

    it 'can reject pets' do
      within("#app-#{@pet1.id}") do
        click_button('Reject')

        expect(current_path).to eq("/admin/applications/#{@app1.id}")
        expect(page).to_not have_button('Reject')
        expect(page).to have_content('Rejected')
      end

      within("#app-#{@pet2.id}") do
        expect(page).to have_button('Reject')
        expect(page).to_not have_content('Rejected')
      end
    end

    it 'does not affect an app if approved/rejected on other app' do
      within("#app-#{@pet1.id}") do
        click_button('Approve')

        expect(current_path).to eq("/admin/applications/#{@app1.id}")
        expect(page).to_not have_button('Approve')
        expect(page).to have_content('Approved')
      end

      within("#app-#{@pet2.id}") do
        click_button('Reject')

        expect(current_path).to eq("/admin/applications/#{@app1.id}")
        expect(page).to_not have_button('Reject')
        expect(page).to have_content('Rejected')
      end

      visit "/admin/applications/#{@app2.id}"

      within("#app-#{@pet1.id}") do
        expect(page).to have_button('Approve')
        expect(page).to_not have_content('Approved')
      end

      within("#app-#{@pet2.id}") do
        expect(page).to have_button('Reject')
        expect(page).to_not have_content('Rejected')
      end
    end
  end

  describe 'approve and reject apps' do
    before :each do
      @shelter = create(:shelter, name: 'Dogtown and Z-Boys')
      @pet1 = create(:pet, shelter: @shelter)
      @pet2 = create(:pet, shelter: @shelter)
      @pet3 = create(:pet, shelter: @shelter)
      @app1 = create(:application, status: 'Pending')
      @app2 = create(:application, status: 'Pending')
      PetApp.create!(application: @app1, pet: @pet1)
      PetApp.create!(application: @app1, pet: @pet2)
      PetApp.create!(application: @app1, pet: @pet3)
      PetApp.create!(application: @app2, pet: @pet1)

      visit "/admin/applications/#{@app1.id}"
    end

    it 'approves app when all pets are approved' do
      expect(@app1.status).to eq('Pending')

      within("#app-#{@pet1.id}") do
        click_button('Approve')
      end

      within("#app-#{@pet2.id}") do
        click_button('Approve')
      end

      @app1.reload

      expect(@app1.status).to eq('Pending')

      within("#app-#{@pet3.id}") do
        click_button('Approve')
      end

      @app1.reload

      expect(@app1.status).to eq('Approved')

      within("#app_info") do
        expect(page).to have_content('Approved')
      end
    end

    it 'rejects app when > 1 pets are rejected and all others have been accepted' do
      within("#app-#{@pet1.id}") do
        click_button('Reject')
      end

      within("#app-#{@pet2.id}") do
        click_button('Approve')
      end

      within("#app-#{@pet3.id}") do
        click_button('Approve')
      end

      within("#app_info") do
        expect(page).to have_content('Rejected')
      end

      @app1.reload
      expect(@app1.status).to eq('Rejected')
    end

    it 'makes pets not adoptable if app approved' do
      within("#app-#{@pet1.id}") do
        click_button('Approve')
      end

      within("#app-#{@pet2.id}") do
        click_button('Approve')
      end

      within("#app-#{@pet3.id}") do
        click_button('Approve')
      end

      @pet1.reload

      expect(@pet1.adoptable).to eq(false)
    end

    it 'cannot approve if pet has approved app' do
      visit "/admin/applications/#{@app2.id}"

      within("#app-#{@pet1.id}") do
        click_button('Approve')
      end

      @pet1.reload

      visit "/admin/applications/#{@app1.id}"

      within("#app-#{@pet1.id}") do
        expect(page).to_not have_button('Approve')
      end
    end
  end
end


# save_and_open_page
