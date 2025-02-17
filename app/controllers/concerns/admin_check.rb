module AdminCheck
  extend ActiveSupport::Concern

  included do
    before_action :check_admin
  end

  private

  def check_admin
    redirect_to root_path, alert: "No tienes permisos para acceder a esta sección" unless current_user&.admin?
  end
end
