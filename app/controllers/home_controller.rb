class HomeController < ApplicationController
  def index
  end
  
  def public_show_vehicle
    @vehicle = Vehiculo.find(params[:id])
    @user = @vehicle.user
  end
end
