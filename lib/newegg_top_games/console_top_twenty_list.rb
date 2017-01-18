require './lib/newegg_top_games'


class NewEggTopGames::ConsoleTopTwentyList
	attr_accessor :list, :console
	def initialize(console)
		@console = console
		@list = [] #has many list items
	end

	def print_list
		puts "#{@console.name}'s top 20 selling items: "
	end
end