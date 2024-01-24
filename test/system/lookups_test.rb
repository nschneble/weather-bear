require "application_system_test_case"

class LookupsTest < ApplicationSystemTestCase
  setup do
    @lookup = lookups(:one)
  end

  test "visiting the index" do
    visit lookups_url
    assert_selector "h1", text: "Lookups"
  end

  test "should create lookup" do
    visit lookups_url
    click_on "New lookup"

    fill_in "Cached at", with: @lookup.cached_at
    fill_in "Scale", with: @lookup.scale
    fill_in "Temperature", with: @lookup.temperature
    fill_in "High", with: @lookup.high
    fill_in "Low", with: @lookup.low
    fill_in "Condition", with: @lookup.condition
    fill_in "Icon", with: @lookup.icon
    fill_in "Zip code", with: @lookup.zip_code
    click_on "Create Lookup"

    assert_text "Lookup was successfully created"
    click_on "Back"
  end

  test "should update Lookup" do
    visit lookup_url(@lookup)
    click_on "Edit this lookup", match: :first

    fill_in "Cached at", with: @lookup.cached_at
    fill_in "Scale", with: @lookup.scale
    fill_in "Temperature", with: @lookup.temperature
    fill_in "High", with: @lookup.high
    fill_in "Low", with: @lookup.low
    fill_in "Condition", with: @lookup.condition
    fill_in "Icon", with: @lookup.icon
    fill_in "Zip code", with: @lookup.zip_code
    click_on "Update Lookup"

    assert_text "Lookup was successfully updated"
    click_on "Back"
  end

  test "should destroy Lookup" do
    visit lookup_url(@lookup)
    click_on "Destroy this lookup", match: :first

    assert_text "Lookup was successfully destroyed"
  end
end
