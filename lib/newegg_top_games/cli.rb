require './lib/newegg_top_games'


class NewEggTopGames::CLI

	CONSOLE_INFO = {
		:playstation_4 => {name: "Playstation 4", url: "https://www.newegg.com/Product/ProductList.aspx?Submit=ENE&N=100021831&IsNodeId=1&Description=playstation%204&name=PS4%20Video%20Games&Order=BESTSELLING&Pagesize=36&isdeptsrh=1" },
		:playstation_3 => {name: "Playstation 3", url: "https://www.newegg.com/PS3-Video-Games/SubCategory/ID-545?Tid=252383"},
		:playstation_2 => {name: "Playstation 2", url: "https://www.newegg.com/PS2-Games/SubCategory/ID-475?Tid=8097"},
		:xbox_one => {name: "Xbox One", url: "https://www.newegg.com/Xbox-One-Video-Games/SubCategory/ID-3218?Tid=21799&Order=BESTSELLING"},
		:xbox_360 => {name: "Xbox 360", url: "https://www.newegg.com/Xbox-360-Games/SubCategory/ID-516?Tid=252388&Order=BESTSELLING"},
		:wii => {name: "Wii", url: "https://www.newegg.com/Product/ProductList.aspx?Submit=ENE&N=100252378&IsNodeId=1&Description=wii%20games&name=Nintendo%20Wii%20Games&Order=BESTMATCH&isdeptsrh=1"},
		:nintendo_ds => {name: "Nintendo DS", url: "https://www.newegg.com/Product/ProductList.aspx?Submit=ENE&N=100008067&IsNodeId=1&Description=nintendo%20ds%20games&name=Nintendo%20DS%20Games&Order=BESTSELLING&Pagesize=36&isdeptsrh=1"},
		:nintendo_switch => {name: "Nintendo Switch", url: "https://www.newegg.com/Nintendo-Switch-Video-Games/SubCategory/ID-3733?Tid=252381"},
		:vr_games => {name: "VR Games", url: "https://www.newegg.com/VR-Games/SubCategory/ID-3722?Tid=245657&Order=BESTSELLING"},
		:pc_games => {name: "PC Games", url: "https://www.newegg.com/Product/ProductList.aspx?Submit=StoreIM&Depa=8&Category=275"}
	}

	def run
		choose_console
		open "http://www.google.com"
	end

	def choose_console
		puts ""
		puts "************************************************************"
		puts "Welcome to New Eggs's top selling video games (by console)!"
		puts "Choose a console...."
		puts "************************************************************"
		input = nil
		puts ""
		
		number = 1
		CONSOLE_INFO.each do |key, value|
			puts "#{number.to_s.yellow}. #{CONSOLE_INFO[key][:name]}"
			number +=1
		end
		puts ""
		puts "************************************************************"
		puts ""
		input = nil
		
		while input != "EXIT"
			print "Choose a console or type #{'exit'.red} to exit (1-10): "
			
			input = gets.chomp.upcase

			case input
			when "1"
				console_menu(CONSOLE_INFO[:playstation_4])
			when "2"
				console_menu(CONSOLE_INFO[:playstation_3])
			when "3"
				console_menu(CONSOLE_INFO[:playstation_2])
			when "4"
				console_menu(CONSOLE_INFO[:xbox_one])
			when "5"
				console_menu(CONSOLE_INFO[:xbox_360])
			when "6"
				console_menu(CONSOLE_INFO[:wii])
			when "7" 
				console_menu(CONSOLE_INFO[:nintendo_ds])
			when "8" 
				console_menu(CONSOLE_INFO[:nintendo_switch])
			when "9"
				console_menu(CONSOLE_INFO[:vr_games])
			when "10"
				console_menu(CONSOLE_INFO[:pc_games])
			when "EXIT"
				exit_program
			else
				puts "Invalid Entry, try again...".red
			end
		end
	end

	def console_menu(console_info)
		list = NewEggTopGames::ConsoleTopTwentyList.new(NewEggTopGames::Console.new(console_info))
		print_list(list)
		input = nil
		
		while input != "EXIT"
			print "Which Item would you like to know more about? Type 'list' to re-list items, 'consoles' to return to consoles, or #{"'exit'".red} to exit (1-#{list.list.length}): "
			input = gets.chomp.upcase
			if input.to_i > 0 && input.to_i <= list.list.length
				product_page = NewEggTopGames::Scraper.product_page(list.list[input.to_i - 1])
				present_product_page(product_page, console_info)
			end
			case input
			when "CONSOLES"
				choose_console
			when "LIST"
				console_menu(console_info)
			when "EXIT"
				exit_program
			else
				puts "Invalid Entry, try again...".red
			end
		end
	end

	def present_product_page(product_page, console_info)
		puts ""
		puts "********************************************************"
		puts "#{product_page.title}"
		puts "********************************************************"
		puts ""
		puts "Price: #{"$".green}#{product_page.price.green}"
		puts "Console: #{product_page.console.name.green}"
		puts ""
		puts "Description:"
		puts "------------------"
		puts ""
		product_page.info_array.each do |item|
			puts item.text.strip
			puts ""
		end
		puts "------------------"
		puts ""
		input = nil
		
		while input != "EXIT"
			print "Type 'list' to go back to the #{console_info[:name].green} list, 'consoles' to go back to the consoles, or #{"'exit'".red} to exit: "
			input = gets.strip.upcase
			case input
			when "LIST"
				console_menu(console_info)
			when "CONSOLES"
				choose_console
			when "EXIT"
				exit_program
			else
				puts "Invalid entry, try again...".red
			end
		end
	end

	def print_list(list)
		list.get_items
		list.list = list.list[0..19]
		puts ""
		puts "NewEgg's top #{list.list.length} selling items for #{list.console.name}: "
		puts "-----------------------------------------------"
	
		list.list.each_with_index do |list_item, index|
			number = index + 1
			puts "#{number.to_s.yellow}. #{list_item.name} (#{list_item.brand.green}) #{list_item.url == nil ? "No More info".red : ""}"
		end
		puts ""
	end

	def exit_program
		puts ""
		puts "Thank you, see you next time!"
		puts ""
		exit!
	end
end


##REFACTOR