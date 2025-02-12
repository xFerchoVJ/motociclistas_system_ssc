require "test_helper"

class PasesTuristicosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pases_turistico = pases_turisticos(:one)
  end

  test "should get index" do
    get pases_turisticos_url
    assert_response :success
  end

  test "should get new" do
    get new_pases_turistico_url
    assert_response :success
  end

  test "should create pases_turistico" do
    assert_difference("PasesTuristico.count") do
      post pases_turisticos_url, params: { pases_turistico: { duracion_dias: @pases_turistico.duracion_dias, fecha_emision: @pases_turistico.fecha_emision, qr_code: @pases_turistico.qr_code, user_id: @pases_turistico.user_id, vigente: @pases_turistico.vigente } }
    end

    assert_redirected_to pases_turistico_url(PasesTuristico.last)
  end

  test "should show pases_turistico" do
    get pases_turistico_url(@pases_turistico)
    assert_response :success
  end

  test "should get edit" do
    get edit_pases_turistico_url(@pases_turistico)
    assert_response :success
  end

  test "should update pases_turistico" do
    patch pases_turistico_url(@pases_turistico), params: { pases_turistico: { duracion_dias: @pases_turistico.duracion_dias, fecha_emision: @pases_turistico.fecha_emision, qr_code: @pases_turistico.qr_code, user_id: @pases_turistico.user_id, vigente: @pases_turistico.vigente } }
    assert_redirected_to pases_turistico_url(@pases_turistico)
  end

  test "should destroy pases_turistico" do
    assert_difference("PasesTuristico.count", -1) do
      delete pases_turistico_url(@pases_turistico)
    end

    assert_redirected_to pases_turisticos_url
  end
end
