
class NewEggTopGames::Console
	attr_accessor :name, :url, :top_twenty_lists

	
	def initialize(hash)
		@name = hash[:name]
		@url = hash[:url]
		@top_twenty_lists = []
	end
end