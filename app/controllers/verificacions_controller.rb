class VerificacionsController < ApplicationController
  before_action :set_verificacion, only: %i[ show edit update destroy ]

  # GET /verificacions or /verificacions.json
  def index
    @verificacions = Verificacion.all
  end

  # GET /verificacions/1 or /verificacions/1.json
  def show
  end

  # GET /verificacions/new
  def new
    @verificacion = Verificacion.new
  end

  # GET /verificacions/1/edit
  def edit
  end

  # POST /verificacions or /verificacions.json
  def create
    @verificacion = Verificacion.new(verificacion_params)

    respond_to do |format|
      if @verificacion.save
        format.html { redirect_to @verificacion, notice: "Verificacion was successfully created." }
        format.json { render :show, status: :created, location: @verificacion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @verificacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /verificacions/1 or /verificacions/1.json
  def update
    respond_to do |format|
      if @verificacion.update(verificacion_params)
        format.html { redirect_to @verificacion, notice: "Verificacion was successfully updated." }
        format.json { render :show, status: :ok, location: @verificacion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @verificacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /verificacions/1 or /verificacions/1.json
  def destroy
    @verificacion.destroy!

    respond_to do |format|
      format.html { redirect_to verificacions_path, status: :see_other, notice: "Verificacion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_verificacion
      @verificacion = Verificacion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def verificacion_params
      params.require(:verificacion).permit(:codigo, :verificado_whatsapp, :verificado_correo, :verificado, :fecha_expiracion, :user_id)
    end
end
