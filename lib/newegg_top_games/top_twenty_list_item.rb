class NewEggTopGames::TopTwentyListItem
	attr_accessor :name, :brand, :url

	def initialize(name, brand, url)
		@name = name
		@brand = brand
		@url = url
	end
end