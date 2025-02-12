class PasesTuristicosController < ApplicationController
  before_action :set_pases_turistico, only: %i[ show edit update destroy ]

  # GET /pases_turisticos or /pases_turisticos.json
  def index
    @pases_turisticos = PasesTuristico.all
  end

  # GET /pases_turisticos/1 or /pases_turisticos/1.json
  def show
  end

  # GET /pases_turisticos/new
  def new
    @pases_turistico = PasesTuristico.new
  end

  # GET /pases_turisticos/1/edit
  def edit
  end

  # POST /pases_turisticos or /pases_turisticos.json
  def create
    @pases_turistico = PasesTuristico.new(pases_turistico_params)

    respond_to do |format|
      if @pases_turistico.save
        format.html { redirect_to @pases_turistico, notice: "Pases turistico was successfully created." }
        format.json { render :show, status: :created, location: @pases_turistico }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pases_turistico.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pases_turisticos/1 or /pases_turisticos/1.json
  def update
    respond_to do |format|
      if @pases_turistico.update(pases_turistico_params)
        format.html { redirect_to @pases_turistico, notice: "Pases turistico was successfully updated." }
        format.json { render :show, status: :ok, location: @pases_turistico }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pases_turistico.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pases_turisticos/1 or /pases_turisticos/1.json
  def destroy
    @pases_turistico.destroy!

    respond_to do |format|
      format.html { redirect_to pases_turisticos_path, status: :see_other, notice: "Pases turistico was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pases_turistico
      @pases_turistico = PasesTuristico.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pases_turistico_params
      params.require(:pases_turistico).permit(:fecha_emision, :duracion_dias, :qr_code, :vigente, :user_id)
    end
end
