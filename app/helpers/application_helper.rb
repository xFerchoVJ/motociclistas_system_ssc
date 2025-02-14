module ApplicationHelper
  def nav_link(text, path, options = {})
    # Determina si el enlace es para la página actual
    current_page = current_page?(path)
    # Agrega una clase adicional si es la página actual
    options[:class] = options[:class] + " bg-blue-700" if current_page
    # Crea el enlace
    link_to text, path, options
  end
end