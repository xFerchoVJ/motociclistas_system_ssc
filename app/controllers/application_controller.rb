class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :nombre, :apellido_paterno, :apellido_materno, :curp, :estado, :municipio,
      :telefono, :es_turista, :club_id, :contacto_emergencia, :telefono_emergencia,
      :donador_organos, :tipo_sangre, :alergias, :medicamento_contraindicado, :role,
      :seguridad_medica
    ])
  end
end
