require "test_helper"

class VerificacionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @verificacion = verificacions(:one)
  end

  test "should get index" do
    get verificacions_url
    assert_response :success
  end

  test "should get new" do
    get new_verificacion_url
    assert_response :success
  end

  test "should create verificacion" do
    assert_difference("Verificacion.count") do
      post verificacions_url, params: { verificacion: { codigo: @verificacion.codigo, fecha_expiracion: @verificacion.fecha_expiracion, user_id: @verificacion.user_id, verificado: @verificacion.verificado, verificado_correo: @verificacion.verificado_correo, verificado_whatsapp: @verificacion.verificado_whatsapp } }
    end

    assert_redirected_to verificacion_url(Verificacion.last)
  end

  test "should show verificacion" do
    get verificacion_url(@verificacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_verificacion_url(@verificacion)
    assert_response :success
  end

  test "should update verificacion" do
    patch verificacion_url(@verificacion), params: { verificacion: { codigo: @verificacion.codigo, fecha_expiracion: @verificacion.fecha_expiracion, user_id: @verificacion.user_id, verificado: @verificacion.verificado, verificado_correo: @verificacion.verificado_correo, verificado_whatsapp: @verificacion.verificado_whatsapp } }
    assert_redirected_to verificacion_url(@verificacion)
  end

  test "should destroy verificacion" do
    assert_difference("Verificacion.count", -1) do
      delete verificacion_url(@verificacion)
    end

    assert_redirected_to verificacions_url
  end
end
