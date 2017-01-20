require './lib/newegg_top_games'


class NewEggTopGames::ConsoleTopTwentyList
	attr_accessor :list, :console

	def initialize(console)
		@console = console
		@list = [] #has many list items
		@console.top_twenty_lists << self
	end

	def get_items
		NewEggTopGames::Scraper.main_site(self)
	end
end