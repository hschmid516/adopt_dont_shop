class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_name
    @shelters_pending = Shelter.pending_apps_ordered
  end

  def show
    @shelter = Shelter.find(params[:id])
  end
end
