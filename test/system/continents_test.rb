require "application_system_test_case"

class ContinentsTest < ApplicationSystemTestCase
  setup do
    @continent = continents(:one)
  end

  test "visiting the index" do
    visit continents_url
    assert_selector "h1", text: "Continents"
  end

  test "creating a Continent" do
    visit continents_url
    click_on "New Continent"

    click_on "Create Continent"

    assert_text "Continent was successfully created"
    click_on "Back"
  end

  test "updating a Continent" do
    visit continents_url
    click_on "Edit", match: :first

    click_on "Update Continent"

    assert_text "Continent was successfully updated"
    click_on "Back"
  end

  test "destroying a Continent" do
    visit continents_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Continent was successfully destroyed"
  end
end
