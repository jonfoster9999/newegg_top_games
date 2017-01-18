require './lib/newegg_top_games'


class NewEggTopGames::CLI

	def run
		main_menu
		choose_console
	end

	def main_menu
		puts "Welcome to New Eggs's top selling video games (by console)!"
		puts "Choose a console...."
	end

	def choose_console
		input = nil
		puts "1. Playstation 4"
		puts "2. Xbox One"
		puts "3. Wii"
		puts "4. Nintendo DS"
		print "Choose a console or type 'exit' to exit: "
		
		input = gets.chomp

		catch :exit do
			case input
			when "1"

				#need to call CLI#console_menu(playstation_console)  here
				#move "NewEggTopGames::ConsoleTopTwentyList.new(playstation_console)" into this method
				# going to need a print item method which takes the href of the corresponding list_item choice, scrapes it and prints it

				#when printing the individual description we'll take a gets.chomp.to_i   and call the item to be printed by it's index 
				NewEggTopGames::ConsoleTopTwentyList.new(NewEggTopGames::Console.new("Playstation 4", "https://www.newegg.com/Product/ProductList.aspx?Submit=ENE&N=100021831&IsNodeId=1&Description=playstation%204&name=PS4%20Video%20Games&Order=BESTSELLING&Pagesize=36&isdeptsrh=1")).print_list
			when "2"
				NewEggTopGames::ConsoleTopTwentyList.new(NewEggTopGames::Console.new("Xbox One", "https://www.newegg.com/Xbox-One-Video-Games/SubCategory/ID-3218?Tid=21799&Order=BESTSELLING")).print_list
			when "3"
				NewEggTopGames::ConsoleTopTwentyList.new(NewEggTopGames::Console.new("Wii", "https://www.newegg.com/Nintendo-Wii-Games/SubCategory/ID-544?Order=BESTSELLING")).print_list
			when "4" 
				NewEggTopGames::ConsoleTopTwentyList.new(NewEggTopGames::Console.new("Nintendo DS", "https://www.newegg.com/Product/ProductList.aspx?Submit=ENE&N=100008067&IsNodeId=1&Description=nintendo%20ds%20games&name=Nintendo%20DS%20Games&Order=BESTSELLING&Pagesize=36&isdeptsrh=1")).print_list
			when "exit"
				throw :exit
			else
				puts ("Invalid Entry, try again").red
				choose_console
		
			end
		end
	end

end