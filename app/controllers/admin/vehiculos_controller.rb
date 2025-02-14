class Admin::VehiculosController < ApplicationController
  before_action :authenticate_user!
  include AdminCheck
  before_action :set_vehiculo, only: [:accept, :decline]

  def accept
    @vehiculo.update(status: :active)
    redirect_to admin_user_path(@vehiculo.user), notice: "Vehículo aceptado correctamente."
  end

  def decline
    @vehiculo.update(status: :inactive)
    redirect_to admin_user_path(@vehiculo.user), notice: "Vehículo rechazado correctamente."
  end
  
  private 

  def set_vehiculo
    @vehiculo = Vehiculo.find(params[:id])
  end
end