class ApplicationsController < ApplicationController
  # def index
  #   @apps = Application.all
  # end

  def show
    @app = Application.find(params[:id])
    if params[:search]
      @pets = Pet.search(params[:search])
    end
  end

  def create
    app = Application.create(app_params)
    if app.save
      redirect_to "/applications/#{app.id}"
    else
      flash[:error] = app.errors.full_messages.to_sentence
      redirect_to "/applications/new"
    end
  end

  def update
    app = Application.find(params[:id])
    app.update(description: params[:description], status: 'Pending')
    redirect_to "/applications/#{app.id}"
  end

  private

  def app_params
    params.permit(:name, :street_address, :city, :state, :zip)
  end
end
