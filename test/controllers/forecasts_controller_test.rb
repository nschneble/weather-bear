require "test_helper"

class ForecastsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @forecast = forecasts(:one)
  end

  test "should get index" do
    get forecasts_url
    assert_response :success
  end

  test "should get new" do
    get new_forecast_url
    assert_response :success
  end

  test "should create forecast" do
    assert_difference("Forecast.count") do
      post forecasts_url, params: { forecast: { condition: @forecast.condition, date: @forecast.date, high: @forecast.high, icon: @forecast.icon, lookup_id: @forecast.lookup_id, low: @forecast.low } }
    end

    assert_redirected_to forecast_url(Forecast.last)
  end

  test "should show forecast" do
    get forecast_url(@forecast)
    assert_response :success
  end

  test "should get edit" do
    get edit_forecast_url(@forecast)
    assert_response :success
  end

  test "should update forecast" do
    patch forecast_url(@forecast), params: { forecast: { condition: @forecast.condition, date: @forecast.date, high: @forecast.high, icon: @forecast.icon, lookup_id: @forecast.lookup_id, low: @forecast.low } }
    assert_redirected_to forecast_url(@forecast)
  end

  test "should destroy forecast" do
    assert_difference("Forecast.count", -1) do
      delete forecast_url(@forecast)
    end

    assert_redirected_to forecasts_url
  end
end
