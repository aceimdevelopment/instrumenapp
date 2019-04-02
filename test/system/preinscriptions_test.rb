require "application_system_test_case"

class PreinscriptionsTest < ApplicationSystemTestCase
  setup do
    @preinscription = preinscriptions(:one)
  end

  test "visiting the index" do
    visit preinscriptions_url
    assert_selector "h1", text: "Preinscriptions"
  end

  test "creating a Preinscription" do
    visit preinscriptions_url
    click_on "New Preinscription"

    fill_in "Area", with: @preinscription.area_id
    fill_in "Lenguage", with: @preinscription.lenguage_id
    fill_in "Studient", with: @preinscription.studient_id
    click_on "Create Preinscription"

    assert_text "Preinscription was successfully created"
    click_on "Back"
  end

  test "updating a Preinscription" do
    visit preinscriptions_url
    click_on "Edit", match: :first

    fill_in "Area", with: @preinscription.area_id
    fill_in "Lenguage", with: @preinscription.lenguage_id
    fill_in "Studient", with: @preinscription.studient_id
    click_on "Update Preinscription"

    assert_text "Preinscription was successfully updated"
    click_on "Back"
  end

  test "destroying a Preinscription" do
    visit preinscriptions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Preinscription was successfully destroyed"
  end
end
