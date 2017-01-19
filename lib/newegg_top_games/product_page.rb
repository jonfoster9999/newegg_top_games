


class NewEggTopGames::ProductPage
	attr_accessor :title, :price, :info_array, :console

	def initialize(title, price, info_array, console)
		@title = title
		@price = price
		@info_array = info_array
		@console = console
	end
end