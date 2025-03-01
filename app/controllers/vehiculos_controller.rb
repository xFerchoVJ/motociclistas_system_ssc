class VehiculosController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user
  before_action :set_vehiculo, only: %i[ show edit update destroy ]

  # GET /vehiculos or /vehiculos.json
  def index
    @vehiculos = Vehiculo.where(user_id: current_user.id)
  end

  # GET /vehiculos/1 or /vehiculos/1.json
  def show
  end

  # GET /vehiculos/new
  def new
    @vehiculo = Vehiculo.new
  end

  # GET /vehiculos/1/edit
  def edit
  end

  # POST /vehiculos or /vehiculos.json
  def create
    @vehiculo = Vehiculo.new(vehiculo_params)
    @vehiculo.user_id = current_user.id
    
    respond_to do |format|
      if @vehiculo.save
        format.html { redirect_to @vehiculo, notice: "Vehículo creado exitosamente." }
        format.json { render :show, status: :created, location: @vehiculo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vehiculo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehiculos/1 or /vehiculos/1.json
  def update
    respond_to do |format|
      if @vehiculo.update(vehiculo_params)
        format.html { redirect_to @vehiculo, notice: "Vehículo actualizado exitosamente." }
        format.json { render :show, status: :ok, location: @vehiculo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vehiculo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehiculos/1 or /vehiculos/1.json
  def destroy
    @vehiculo.destroy!

    respond_to do |format|
      format.html { redirect_to vehiculos_path, status: :see_other, notice: "Vehículo eliminado exitosamente." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehiculo
      @vehiculo = Vehiculo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vehiculo_params
      params.require(:vehiculo).permit(:marca, :modelo, :linea, :anio, :placa, :estado_emplacamiento, :numero_serie, :tipo_servicio, :user_id)
    end

    def check_user
      if current_user.admin?
        redirect_to root_path
      end
    end
end