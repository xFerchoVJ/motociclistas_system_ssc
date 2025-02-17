class Admin::UsersController < ApplicationController
  include AdminCheck
  before_action :authenticate_user!
  before_action :set_user, only: %i[ show destroy reactivate approve_user]

  def index
    @q = User.where.not(role: 1).order(created_at: :desc).ransack(params[:q]) # Excluye administradores
    @users = @q.result(distinct: true).page(params[:page]).per(5)
  end

  def approve_user
    if @user.update!(status: :active)
      redirect_to admin_users_path, notice: "Usuario aprobado correctamente"
    else
      redirect_to admin_users_path, alert: "No se pudo aprobar el usuario"
    end
  end
  

  def show
  end
  
  def destroy
    @user.soft_delete
    redirect_to admin_users_path, notice: "Usuario desactivado correctamente"
  end

  def reactivate
    @user.update(status: :active)
    redirect_to admin_users_path, notice: "Usuario reactivado correctamente"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end