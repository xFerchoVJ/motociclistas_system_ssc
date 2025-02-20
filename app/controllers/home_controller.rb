class HomeController < ApplicationController
  def index
  end
  
  def public_show_vehicle
    @vehicle = Vehiculo.find(params[:id])
    @user = @vehicle.user
  end

  def info_user
    @user = User.find(params[:id])
    @constancia = Constancia.find(params[:constancia_id])
    if @constancia.fecha_expiracion < DateTime.now
      @expired = true
    else
      @expired = false
    end
  end
end
