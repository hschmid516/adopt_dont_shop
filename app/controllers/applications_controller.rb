class ApplicationsController < ApplicationController
  def show
    @app = Application.find(params[:id])
    if params[:search]
      @pets = Pet.search(params[:search])
    end
  end

  def create
    app = Application.create(application_params)
    if app.save
      redirect_to "/applications/#{app.id}"
    else
      flash[:error] = app.errors.full_messages.to_sentence
      redirect_to "/applications/new"
    end
  end

  private

  def application_params
    params
      .permit(:name, :street_address, :city, :state, :zip)
      .with_defaults(status: 'In Progress')
  end
end
