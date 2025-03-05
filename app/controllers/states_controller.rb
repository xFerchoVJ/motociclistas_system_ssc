class StatesController < ApplicationController
  def estados
    estados = Estado.pluck(:nombre).uniq
    render json: estados
  end

  def municipios
    estado = Estado.find_by(nombre: params[:estado])
    municipios = estado.municipios.pluck(:nombre).sort if estado
    render json: municipios || []
  end
end