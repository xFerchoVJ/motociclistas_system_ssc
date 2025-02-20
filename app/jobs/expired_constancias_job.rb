class ExpiredConstanciasJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    Constancia.where("fecha_expiracion < ?", DateTime.now).where(status: true).update_all(status: false)
  end
end
