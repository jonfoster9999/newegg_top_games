require './lib/newegg_top_games'


class NewEggTopGames::CLI

	CONSOLE_INFO = {
		:playstation_4 => {name: "Playstation 4", url: "https://www.newegg.com/Product/ProductList.aspx?Submit=ENE&N=100021831&IsNodeId=1&Description=playstation%204&name=PS4%20Video%20Games&Order=BESTSELLING&Pagesize=36&isdeptsrh=1" },
		:playstation_3 => {name: "Playstation 3", url: "https://www.newegg.com/PS3-Video-Games/SubCategory/ID-545?Tid=252383"},
		:xbox_one => {name: "Xbox One", url: "https://www.newegg.com/Xbox-One-Video-Games/SubCategory/ID-3218?Tid=21799&Order=BESTSELLING"},
		:wii => {name: "Wii", url: "https://www.newegg.com/Product/ProductList.aspx?Submit=ENE&N=100252378&IsNodeId=1&Description=wii%20games&name=Nintendo%20Wii%20Games&Order=BESTMATCH&isdeptsrh=1"},
		:nintendo_ds => {name: "Nintendo DS", url: "https://www.newegg.com/Product/ProductList.aspx?Submit=ENE&N=100008067&IsNodeId=1&Description=nintendo%20ds%20games&name=Nintendo%20DS%20Games&Order=BESTSELLING&Pagesize=36&isdeptsrh=1"},
		:nintendo_switch => {name: "Nintendo Switch", url: "https://www.newegg.com/Nintendo-Switch-Video-Games/SubCategory/ID-3733?Tid=252381"},
		:vr_games => {name: "VR Games", url: "https://www.newegg.com/VR-Games/SubCategory/ID-3722?Tid=245657&Order=BESTSELLING"},
		:pc_games => {name: "PC Games", url: "https://www.newegg.com/Product/ProductList.aspx?Submit=StoreIM&Depa=8&Category=275"}
	}

	def run
		main_menu
		choose_console
	end

	def main_menu
		puts ""
		puts "Welcome to New Eggs's top selling video games (by console)!"
		puts "Choose a console...."
	end

	def consoles 
		@@consoles
	end

	def choose_console
		input = nil
		puts ""
		puts "#{"1.".blue} Playstation 4"
		puts "#{"2.".blue} Playstation 3"
		puts "#{"3.".blue} Xbox One"
		puts "#{"4.".blue} Wii"
		puts "#{"5.".blue} Nintendo DS"
		puts "#{"6.".blue} Nintendo Switch"
		puts "#{"7.".blue} VR Games"
		puts "#{"8.".blue} PC Games"
		puts ""
		print "Choose a console or type 'exit' to exit: "
		
		input = gets.chomp

		catch :exit do
			case input
			when "1"

				#need to call CLI#console_menu(playstation_console)  here
				#move "NewEggTopGames::ConsoleTopTwentyList.new(playstation_console)" into this method
				# going to need a print item method which takes the href of the corresponding list_item choice, scrapes it and prints it

				#when printing the individual description we'll take a gets.chomp.to_i   and call the item to be printed by it's index 
				NewEggTopGames::ConsoleTopTwentyList.new(NewEggTopGames::Console.new(CONSOLE_INFO[:playstation_4])).print_list
			when "2"
				NewEggTopGames::ConsoleTopTwentyList.new(NewEggTopGames::Console.new(CONSOLE_INFO[:playstation_3])).print_list
			when "3"
				NewEggTopGames::ConsoleTopTwentyList.new(NewEggTopGames::Console.new(CONSOLE_INFO[:xbox_one])).print_list
			when "4"
				NewEggTopGames::ConsoleTopTwentyList.new(NewEggTopGames::Console.new(CONSOLE_INFO[:wii])).print_list
			when "5" 
				NewEggTopGames::ConsoleTopTwentyList.new(NewEggTopGames::Console.new(CONSOLE_INFO[:nintendo_ds])).print_list
			when "6" 
				NewEggTopGames::ConsoleTopTwentyList.new(NewEggTopGames::Console.new(CONSOLE_INFO[:nintendo_switch])).print_list
			when "7"
				NewEggTopGames::ConsoleTopTwentyList.new(NewEggTopGames::Console.new(CONSOLE_INFO[:vr_games])).print_list
			when "8"
				NewEggTopGames::ConsoleTopTwentyList.new(NewEggTopGames::Console.new(CONSOLE_INFO[:pc_games])).print_list
			when "exit"
				throw :exit
			else
				puts ("Invalid Entry, try again").red
				choose_console
			end
		end
	end
end


##REFACTOR