require "application_system_test_case"

class ClubsTest < ApplicationSystemTestCase
  setup do
    @club = clubs(:one)
  end

  test "visiting the index" do
    visit clubs_url
    assert_selector "h1", text: "Clubs"
  end

  test "should create club" do
    visit clubs_url
    click_on "New club"

    fill_in "Direccion", with: @club.direccion
    fill_in "Email", with: @club.email
    fill_in "Estado", with: @club.estado
    fill_in "Municipio", with: @club.municipio
    fill_in "Nombre", with: @club.nombre
    fill_in "Representante", with: @club.representante
    fill_in "Telefono", with: @club.telefono
    click_on "Create Club"

    assert_text "Club was successfully created"
    click_on "Back"
  end

  test "should update Club" do
    visit club_url(@club)
    click_on "Edit this club", match: :first

    fill_in "Direccion", with: @club.direccion
    fill_in "Email", with: @club.email
    fill_in "Estado", with: @club.estado
    fill_in "Municipio", with: @club.municipio
    fill_in "Nombre", with: @club.nombre
    fill_in "Representante", with: @club.representante
    fill_in "Telefono", with: @club.telefono
    click_on "Update Club"

    assert_text "Club was successfully updated"
    click_on "Back"
  end

  test "should destroy Club" do
    visit club_url(@club)
    click_on "Destroy this club", match: :first

    assert_text "Club was successfully destroyed"
  end
end
