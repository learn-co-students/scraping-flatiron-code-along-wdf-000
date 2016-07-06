require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

  def get_page
    doc =Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

  def get_courses
    get_page.css(".posts-holder .post")
  end


  def make_courses
   
    get_courses.each do |course| 
        n_course = Course.new
        n_course.title = course.css("h2").text
        n_course.schedule = course.css(".date").text
        binding.pry
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



