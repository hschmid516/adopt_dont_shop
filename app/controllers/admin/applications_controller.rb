class Admin::ApplicationsController < ApplicationController
  def show
    @app = Application.find(params[:id])
  end

  def update
    @app = Application.find(params[:id])
    pet_app = PetApp.pet_app_by_ids(params[:pet_id], params[:id])
    if params[:approve]
      pet_app.update(status: 'Approved')
      if @app.pets_approved?
        @app.update(status: 'Approved')
      elsif @app.pets_rejected?
        @app.update(status: 'Rejected')
      end
    else
      pet_app.update(status: 'Rejected')
      if @app.pets_rejected?
        @app.update(status: 'Rejected')
      end
    end
    redirect_to "/admin/applications/#{@app.id}"
  end
end

# redirect_to "/admin/applications/#{@app.id}?pet_id=#{params[:pet_id]}"
