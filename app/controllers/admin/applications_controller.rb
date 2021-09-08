class Admin::ApplicationsController < ApplicationController
  def show
    @app = Application.find(params[:id])
  end

  def update
    app = Application.find(params[:id])
    pet_app = PetApp.pet_app_by_ids(params[:pet_id], params[:id])
    pet_app.update_status!(params[:approve])
    app.update_status!
    app.adopt_pets! if app.status == 'Approved'
    redirect_to "/admin/applications/#{app.id}"
  end
end
