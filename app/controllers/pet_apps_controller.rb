class PetAppsController < ApplicationController
  before_action :find_by_id, only: [:create, :update]

  def create
    PetApp.create(application: @app, pet: @pet)
    redirect_to "/applications/#{@app.id}"
  end

  private

  def find_by_id
    @pet = Pet.find(params[:pet_id])
    @app = Application.find(params[:id])
  end
end
