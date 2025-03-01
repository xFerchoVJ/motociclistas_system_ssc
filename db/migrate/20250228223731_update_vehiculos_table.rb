class UpdateVehiculosTable < ActiveRecord::Migration[7.1]
    def change
      change_table :vehiculos do |t|
        # Cambiar 'submarca' a 'marca'
        t.rename :submarca, :linea
  
        # Cambiar 'anio' a 'tipo_servicio'
        t.remove :anio
        t.string :tipo_servicio
  
        # Cambiar 'vin' a 'numero_serie'
        t.rename :vin, :numero_serie
      end
  end
end
