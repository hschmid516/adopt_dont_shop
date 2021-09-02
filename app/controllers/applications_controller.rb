class ApplicationsController < ApplicationController
  def show
    @app = Application.find(params[:id])
    @pets = Pet.pets_in_app(params[:id])
  end
end
