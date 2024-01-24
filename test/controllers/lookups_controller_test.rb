require "test_helper"

class LookupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lookup = lookups(:one)
  end

  test "should get index" do
    get lookups_url
    assert_response :success
  end

  test "should get new" do
    get new_lookup_url
    assert_response :success
  end

  test "should create lookup" do
    assert_difference("Lookup.count") do
      post lookups_url, params: { lookup: { cached_at: @lookup.cached_at, scale: @lookup.scale, temperature: @lookup.temperature, high: @lookup.high, low: @lookup.low, condition: @lookup.condition, icon: @lookup.icon, zip_code: @lookup.zip_code } }
    end

    assert_redirected_to lookup_url(Lookup.last)
  end

  test "should show lookup" do
    get lookup_url(@lookup)
    assert_response :success
  end

  test "should get edit" do
    get edit_lookup_url(@lookup)
    assert_response :success
  end

  test "should update lookup" do
    patch lookup_url(@lookup), params: { lookup: { cached_at: @lookup.cached_at, scale: @lookup.scale, temperature: @lookup.temperature, high: @lookup.high, low: @lookup.low, condition: @lookup.condition, icon: @lookup.icon, zip_code: @lookup.zip_code } }
    assert_redirected_to lookup_url(@lookup)
  end

  test "should destroy lookup" do
    assert_difference("Lookup.count", -1) do
      delete lookup_url(@lookup)
    end

    assert_redirected_to lookups_url
  end
end
