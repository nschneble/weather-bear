module LookupsHelper
	GEOCODING_API_BASE_URL = 'https://geocode.maps.co/search?'.freeze
	GEOCODING_API_KEY = Figaro.env.geocoding_api_key.freeze

	WEATHER_API_BASE_URL = 'https://api.weatherapi.com/v1/forecast.json?'.freeze
	WEATHER_API_KEY = Figaro.env.weather_api_key.freeze

	GEOCODING_EXTRACT_ZIP_CODE_REGEX = /^.+, (?<zip_code>\d{5}), United States$/
	ZIP_CODE_REGEX = /^\d{5}$/

	def query_is_zip_code(query)
		ZIP_CODE_REGEX.match(query).present?
	end

	def lookup_zip_code_params_from_query(query)
		# can't do anything, so just return the OG query and hope for the best!
		return query unless Figaro.env.geocoding_api_key?

		# let's goooooooooooo
		url = "#{GEOCODING_API_BASE_URL}api_key=#{GEOCODING_API_KEY}&q=#{query}"
		response = HTTParty.get(url)

		return query unless response.code == 200

		data = JSON.parse(response.body)

		match_data = GEOCODING_EXTRACT_ZIP_CODE_REGEX.match(data[0]['display_name'])
		return match_data['zip_code'] if match_data.present? && query_is_zip_code(match_data['zip_code'])

		query
	end

	def supply_lookup_params_from_weather_query(zip_code, scale)
		url = "#{WEATHER_API_BASE_URL}key=#{WEATHER_API_KEY}&q=#{zip_code}&days=7&aqi=no&alerts=no"
		response = HTTParty.get(url)

		return {} unless response.code == 200

		params = {}
		params[:zip_code] = zip_code
		params[:cached_at] = Time.now.to_s
		params[:scale] = scale

		data = JSON.parse(response.body)

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
