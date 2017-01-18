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
			top_twenty_list.list << list_item
		end
	end

	def self.product_page(top_twenty_list_item)
		url = top_twenty_list_item.url
		doc = Nokogiri::HTML(open(url))
		binding.pry

	end


end