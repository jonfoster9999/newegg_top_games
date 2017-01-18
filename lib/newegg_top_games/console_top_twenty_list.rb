require './lib/newegg_top_games'


class NewEggTopGames::ConsoleTopTwentyList
	attr_accessor :list, :console
	def initialize(console)
		@console = console
		@list = [] #has many list items
	end

	def print_list
		get_items
		@list = @list[0..19]
		puts ""
		puts "NewEgg's top 20 selling items for #{@console.name}: "
		puts ""
		@list.each_with_index do |list_item, index|
			puts "#{index + 1}. #{list_item.name} (#{list_item.brand.green}) #{list_item.url == nil ? "No More info".red : ""}"
		end
		puts ""
	end


	def get_items
		NewEggTopGames::Scraper.main_site(self)
	end
end