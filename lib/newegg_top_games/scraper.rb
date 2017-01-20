require './lib/newegg_top_games'
require 'open-uri'

class NewEggTopGames::Scraper

	def self.main_site(top_twenty_list)
		url = top_twenty_list.console.url
		doc = Nokogiri::HTML(open(url))
		items = doc.css(".item-container")
		items.each do |item|
			name = item.css('.item-title').text.strip
			begin
				brand = item.css('.item-brand img').attr("title").text
			rescue 
				brand = "No brand given"
			end
			begin
				url = "http:#{item.css('.item-info a.item-title').first.attr("href")}"
			rescue
				url = nil
			end
			list_item = NewEggTopGames::TopTwentyListItem.new(name, brand, url)
			list_item.console = top_twenty_list.console
			top_twenty_list.list << list_item
		end
	end

	def self.product_page(top_twenty_list_item)
		doc = Nokogiri::HTML(open(top_twenty_list_item.url, :allow_redirections => :safe))
		title = doc.css('h1 span').text.strip.split(" - ")[0]
		price = doc.css('div meta').first["content"]
		info_array = doc.css('li.item')
		console = top_twenty_list_item.console
		product_page = NewEggTopGames::ProductPage.new(title, price, info_array, console)
		product_page
	end
end
