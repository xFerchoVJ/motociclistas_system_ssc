require "application_system_test_case"

class VehiculosTest < ApplicationSystemTestCase
  setup do
    @vehiculo = vehiculos(:one)
  end

  test "visiting the index" do
    visit vehiculos_url
    assert_selector "h1", text: "Vehiculos"
  end

  test "should create vehiculo" do
    visit vehiculos_url
    click_on "New vehiculo"

    fill_in "Anio", with: @vehiculo.anio
    fill_in "Estado emplacamiento", with: @vehiculo.estado_emplacamiento
    fill_in "Marca", with: @vehiculo.marca
    fill_in "Modelo", with: @vehiculo.modelo
    fill_in "Placa", with: @vehiculo.placa
    fill_in "Submarca", with: @vehiculo.submarca
    fill_in "User", with: @vehiculo.user_id
    fill_in "Vin", with: @vehiculo.vin
    click_on "Create Vehiculo"

    assert_text "Vehiculo was successfully created"
    click_on "Back"
  end

  test "should update Vehiculo" do
    visit vehiculo_url(@vehiculo)
    click_on "Edit this vehiculo", match: :first

    fill_in "Anio", with: @vehiculo.anio
    fill_in "Estado emplacamiento", with: @vehiculo.estado_emplacamiento
    fill_in "Marca", with: @vehiculo.marca
    fill_in "Modelo", with: @vehiculo.modelo
    fill_in "Placa", with: @vehiculo.placa
    fill_in "Submarca", with: @vehiculo.submarca
    fill_in "User", with: @vehiculo.user_id
    fill_in "Vin", with: @vehiculo.vin
    click_on "Update Vehiculo"

    assert_text "Vehiculo was successfully updated"
    click_on "Back"
  end

  test "should destroy Vehiculo" do
    visit vehiculo_url(@vehiculo)
    click_on "Destroy this vehiculo", match: :first

    assert_text "Vehiculo was successfully destroyed"
  end
end
