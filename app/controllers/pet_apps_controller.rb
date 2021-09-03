class PetAppsController < ApplicationController
  def create
    pet = Pet.find(params[:pet_id])
    app = Application.find(params[:id])
    @pet_app = PetApp.create(application: app, pet: pet)
    redirect_to "/applications/#{app.id}"
  end
end
