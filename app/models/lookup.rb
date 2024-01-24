class Lookup < ApplicationRecord
	has_many :forecasts

	def with_scale(attribute)
		return "#{self[attribute]}℉" if scale.eql? 'fahrenheit'
		"#{self[attribute]}℃"
	end
end
