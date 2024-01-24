module LookupsHelper
	WEATHER_API_BASE_URL = 'https://api.weatherapi.com/v1/forecast.json?'.freeze
	WEATHER_API_KEY = Figaro.env.weather_api_key.freeze

	def supply_lookup_params_from_weather_query(query, scale)
		url = "#{WEATHER_API_BASE_URL}key=#{WEATHER_API_KEY}&q=#{query}&days=7&aqi=no&alerts=no"
		response = HTTParty.get(url)

		return {} unless response.code == 200

		params = {}
		params[:zip_code] = query
		params[:cached_at] = Time.now.to_s
		params[:scale] = scale

		data = JSON.parse(response.body)
		current = data['current']

		# checks if we should store results in Fahrenheit or Celsius
		if scale.eql? 'fahrenheit'
			params[:temperature] = data['current']['temp_f']
			params[:high] = data['forecast']['forecastday'][0]['day']['maxtemp_f']
			params[:low] = data['forecast']['forecastday'][0]['day']['mintemp_f']
		else
			params[:temperature] = data['current']['temp_c']
			params[:high] = data['forecast']['forecastday'][0]['day']['maxtemp_c']
			params[:low] = data['forecast']['forecastday'][0]['day']['mintemp_c']
		end

		params[:condition] = data['current']['condition']['text']
		params[:icon] = data['current']['condition']['icon']

		params
	end
end
