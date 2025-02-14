class Admin::ClubsController < ApplicationController
  include AdminCheck
  before_action :authenticate_user!
  before_action :set_club, only: %i[ show edit update destroy ]

  # GET /clubs or /clubs.json
  def index
    @q = Club.ransack(params[:q])
    @clubs = @q.result(distinct: true).page(params[:page]).per(5)
  end

  # GET /clubs/1 or /clubs/1.json
  def show
  end

  # GET /clubs/new
  def new
    @club = Club.new
  end

  # GET /clubs/1/edit
  def edit
  end

  # POST /clubs or /clubs.json
  def create
    @club = Club.new(club_params)

    respond_to do |format|
      if @club.save
        format.html { redirect_to admin_club_path(@club), notice: "Club creado correctamente." }
        format.json { render :show, status: :created, location: @club }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clubs/1 or /clubs/1.json
  def update
    respond_to do |format|
      if @club.update(club_params)
        format.html { redirect_to admin_club_path(@club), notice: "Club actualizado correctamente." }
        format.json { render :show, status: :ok, location: @club }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clubs/1 or /clubs/1.json
  def destroy
    @club.destroy!

    respond_to do |format|
      format.html { redirect_to admin_clubs_path status: :see_other, notice: "Club eliminado correctamente." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_club
      @club = Club.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def club_params
      params.require(:club).permit(:nombre, :direccion, :estado, :municipio, :telefono, :email, :representante)
    end
end
