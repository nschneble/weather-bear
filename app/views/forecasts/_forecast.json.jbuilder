json.extract! forecast, :id, :date, :high, :low, :condition, :icon, :lookup_id, :created_at, :updated_at
json.url forecast_url(forecast, format: :json)
