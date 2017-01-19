


class NewEggTopGames::ProductPage
	attr_accessor :title, :price, :info_array

	def initialize(title, price, info_array)
		@title = title
		@price = price
		@info_array = info_array
	end
end