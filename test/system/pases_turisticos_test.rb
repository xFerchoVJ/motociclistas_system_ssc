require "application_system_test_case"

class PasesTuristicosTest < ApplicationSystemTestCase
  setup do
    @pases_turistico = pases_turisticos(:one)
  end

  test "visiting the index" do
    visit pases_turisticos_url
    assert_selector "h1", text: "Pases turisticos"
  end

  test "should create pases turistico" do
    visit pases_turisticos_url
    click_on "New pases turistico"

    fill_in "Duracion dias", with: @pases_turistico.duracion_dias
    fill_in "Fecha emision", with: @pases_turistico.fecha_emision
    fill_in "Qr code", with: @pases_turistico.qr_code
    fill_in "User", with: @pases_turistico.user_id
    check "Vigente" if @pases_turistico.vigente
    click_on "Create Pases turistico"

    assert_text "Pases turistico was successfully created"
    click_on "Back"
  end

  test "should update Pases turistico" do
    visit pases_turistico_url(@pases_turistico)
    click_on "Edit this pases turistico", match: :first

    fill_in "Duracion dias", with: @pases_turistico.duracion_dias
    fill_in "Fecha emision", with: @pases_turistico.fecha_emision
    fill_in "Qr code", with: @pases_turistico.qr_code
    fill_in "User", with: @pases_turistico.user_id
    check "Vigente" if @pases_turistico.vigente
    click_on "Update Pases turistico"

    assert_text "Pases turistico was successfully updated"
    click_on "Back"
  end

  test "should destroy Pases turistico" do
    visit pases_turistico_url(@pases_turistico)
    click_on "Destroy this pases turistico", match: :first

    assert_text "Pases turistico was successfully destroyed"
  end
end
