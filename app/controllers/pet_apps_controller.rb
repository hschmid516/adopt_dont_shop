class PetAppsController < ApplicationController
  before_action :find_by_id, only: [:create, :update]

  def create
    PetApp.create(application: @app, pet: @pet)
    redirect_to "/applications/#{@app.id}"
  end

  # def update
  #   pet_app = PetApp.pet_app_by_ids(params[:pet_id], params[:id])
  #   if params[:approve]
  #     pet_app.update(status: 'Approved')
  #     if @app.pets_approved?
  #       @app.update(status: 'Approved')
  #     end
  #   else
  #     pet_app.update(status: 'Rejected')
  #   end
  #   redirect_to "/admin/applications/#{@app.id}?pet_id=#{@pet.id}"
  # end

  private

  def find_by_id
    @pet = Pet.find(params[:pet_id])
    @app = Application.find(params[:id])
  end
end
