require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper

	def get_page
		Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
		#doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
		##binding.pry
		#doc.css(".post").each do |x|
		#	course = Course.new
		#	course.title = x.css("h2").text
		#	course.schedule = x.css(".date").text
		#	course.description = x.css("p").text
		#end
		##binding.pry
	end

	def get_courses
		self.get_page.css(".post")
	end

	def make_courses
		self.get_courses.each do |x|
			course = Course.new
			course.title = x.css("h2").text
			course.schedule = x.css(".date").text
			course.description = x.css("p").text
		end
	end
  
	def print_courses
		self.make_courses
		Course.all.each do |course|
			if course.title
				puts "Title: #{course.title}"
				puts "  Schedule: #{course.schedule}"
				puts "  Description: #{course.description}"
			end
		end
	end
  
end

Scraper.new.get_page
