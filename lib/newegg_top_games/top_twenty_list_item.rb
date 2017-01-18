class NewEggTopGames::TopTwentyListItem
	attr_accessor :name, :brand, :url, :console   #A top twenty list item belongs_to a console

	def initialize(name, brand, url)
		@name = name
		@brand = brand
		@url = url
	end
end