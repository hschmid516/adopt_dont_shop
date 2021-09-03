class ApplicationsController < ApplicationController
  def show
    @app = Application.find(params[:id])
    # @pets = Pet.pets_in_app(params[:id])
  end

  def create
    @app = Application.create(application_params)
    redirect_to "/applications/#{@app.id}"
  end

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip)
  end
end
