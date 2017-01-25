require './lib/newegg_top_games'


class NewEggTopGames::CLI

	CONSOLE_INFO = [
		{name: "Playstation 4", url: "https://www.newegg.com/Product/ProductList.aspx?Submit=ENE&N=100021831&IsNodeId=1&Description=playstation%204&name=PS4%20Video%20Games&Order=BESTSELLING&Pagesize=36&isdeptsrh=1" },
		{name: "Playstation 3", url: "https://www.newegg.com/PS3-Video-Games/SubCategory/ID-545?Tid=252383"},
		{name: "Playstation 2", url: "https://www.newegg.com/PS2-Games/SubCategory/ID-475?Tid=8097"},
		{name: "Xbox One", url: "https://www.newegg.com/Xbox-One-Video-Games/SubCategory/ID-3218?Tid=21799&Order=BESTSELLING"},
		{name: "Xbox 360", url: "https://www.newegg.com/Xbox-360-Games/SubCategory/ID-516?Tid=252388&Order=BESTSELLING"},
		{name: "Wii", url: "https://www.newegg.com/Product/ProductList.aspx?Submit=ENE&N=100252378&IsNodeId=1&Description=wii%20games&name=Nintendo%20Wii%20Games&Order=BESTMATCH&isdeptsrh=1"},
		{name: "Wii U", url: "https://www.newegg.com/Nintendo-Wii-U-Games/SubCategory/ID-3005?Tid=19153"},
		{name: "Nintendo DS", url: "https://www.newegg.com/Product/ProductList.aspx?Submit=ENE&N=100008067&IsNodeId=1&Description=nintendo%20ds%20games&name=Nintendo%20DS%20Games&Order=BESTSELLING&Pagesize=36&isdeptsrh=1"},
		{name: "Nintendo Switch", url: "https://www.newegg.com/Nintendo-Switch-Video-Games/SubCategory/ID-3733?Tid=252381"},
		{name: "VR Games", url: "https://www.newegg.com/VR-Games/SubCategory/ID-3722?Tid=245657&Order=BESTSELLING"},
		{name: "PC Games", url: "https://www.newegg.com/Product/ProductList.aspx?Submit=StoreIM&Depa=8&Category=275"},
		{name: "Featured Items", url:"https://www.newegg.com/Product/ProductList.aspx?Submit=StoreIM&Depa=8"}
	]

	def run
		choose_console		
	end

	def choose_console
		puts ""
		puts "************************************************************".colorize(:color => :yellow).colorize(:background => :light_blue)
		puts "	 _ _  _____ __ __  ___ __ _ __ _                    ".colorize(:color => :white).colorize(:background => :light_blue)
		puts "	| ' \\/ -_) V  V / / -_) _` / _` |                   ".colorize(:color => :white).colorize(:background => :light_blue)
		puts "	|_||_\\___|\\_/\\_/  \\___\\__, \\__, |  top games        ".colorize(:color => :white).colorize(:background => :light_blue)
        puts "                              |___/|___/                    ".colorize(:color => :white).colorize(:background => :light_blue)
		puts "************************************************************".colorize(:color => :yellow).colorize(:background => :light_blue)
		input = nil
		puts ""
		number = 1
		CONSOLE_INFO.each do |console|
		 	spacer = number.to_s.length < 2 ? "  " : " "
		 	puts "#{number.to_s.yellow}.#{spacer}#{console[:name]}"
		 	number +=1
		 end
		puts ""
		puts "************************************************************"
		puts ""
		input = nil
		
		while input != "EXIT"
			print "Choose a console or type #{'exit'.red} to exit (1-#{CONSOLE_INFO.length}): "			
			input = gets.chomp.downcase
			if input == "exit"
				exit_program
			else
				index = input.to_i - 1
			end
			console = CONSOLE_INFO[index]

			if console
				console_menu(console)
			else
				puts "Invalid Entry, try again...".red
			end
		end
	end

	def console_menu(console_info)
		console = NewEggTopGames::Console.new(console_info)
		list = NewEggTopGames::ConsoleTopTwentyList.new(console)
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

	def present_product_page(game, console_info)
		price = game.price.split('.')[1].length == 1 ? game.price + "0" : game.price
		console_name = game.console.name
		puts ""
		puts "********************************************************"
		puts "#{game.title}"
		puts "********************************************************"
		puts ""
		puts "Price:   #{"$".green}#{price.green}"
		puts "Console: #{console_name.green}"
		puts ""
		puts "Description:".light_blue
		puts "------------------"
		puts ""
		game.info_array.each do |item|
			puts item.text.strip
			puts ""
		end
		puts "------------------"
		puts ""
		input = nil
		
		while input != "EXIT"
			print "Type 'list' to go back to the #{console_name.green} list, 'consoles' to go back to the consoles, or #{"'exit'".red} to exit: "
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
		list.get_items 						#populates the list's list_array
		list.list = list.list[0..24] 		#truncates the array down to 20 items
		puts ""
		puts "NewEgg's top #{list.list.length.to_s.green} selling items for #{list.console.name.green}: "
		puts "-----------------------------------------------"
	
		list.list.each_with_index do |list_item, index|
			number = index + 1
			spacer = number.to_s.length < 2 ? "  " : " "
			puts "#{number.to_s}.#{spacer}#{list_item.name} (#{list_item.brand}) #{list_item.url == nil ? "No More info".red : ""}"
		end
		puts ""
	end

	def exit_program
		puts ""
		puts "Thank you, see you next time!"
		puts ""
		exit
	end
end


##REFACTOR