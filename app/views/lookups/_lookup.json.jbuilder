json.extract! lookup, :id, :zip_code, :cached_at, :scale, :temperature, :high, :low, :condition, :icon, :created_at, :updated_at
json.url lookup_url(lookup, format: :json)
