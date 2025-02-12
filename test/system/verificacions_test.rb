require "application_system_test_case"

class VerificacionsTest < ApplicationSystemTestCase
  setup do
    @verificacion = verificacions(:one)
  end

  test "visiting the index" do
    visit verificacions_url
    assert_selector "h1", text: "Verificacions"
  end

  test "should create verificacion" do
    visit verificacions_url
    click_on "New verificacion"

    fill_in "Codigo", with: @verificacion.codigo
    fill_in "Fecha expiracion", with: @verificacion.fecha_expiracion
    fill_in "User", with: @verificacion.user_id
    check "Verificado" if @verificacion.verificado
    check "Verificado correo" if @verificacion.verificado_correo
    check "Verificado whatsapp" if @verificacion.verificado_whatsapp
    click_on "Create Verificacion"

    assert_text "Verificacion was successfully created"
    click_on "Back"
  end

  test "should update Verificacion" do
    visit verificacion_url(@verificacion)
    click_on "Edit this verificacion", match: :first

    fill_in "Codigo", with: @verificacion.codigo
    fill_in "Fecha expiracion", with: @verificacion.fecha_expiracion
    fill_in "User", with: @verificacion.user_id
    check "Verificado" if @verificacion.verificado
    check "Verificado correo" if @verificacion.verificado_correo
    check "Verificado whatsapp" if @verificacion.verificado_whatsapp
    click_on "Update Verificacion"

    assert_text "Verificacion was successfully updated"
    click_on "Back"
  end

  test "should destroy Verificacion" do
    visit verificacion_url(@verificacion)
    click_on "Destroy this verificacion", match: :first

    assert_text "Verificacion was successfully destroyed"
  end
end
