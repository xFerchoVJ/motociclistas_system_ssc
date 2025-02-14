class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  include AdminCheck
  before_action :set_user, only: %i[ show destroy reactivate]

  def index
    @q = User.where.not(role: 1).ransack(params[:q]) # Excluye administradores
    @users = @q.result(distinct: true).page(params[:page]).per(5)
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