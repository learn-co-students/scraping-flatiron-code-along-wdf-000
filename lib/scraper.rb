require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  
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

# html = open("http://learn-co-curriculum.github.io/site-for-scraping/courses")

  def get_page
    # get the whole page with Nokogiri + open-uri
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

  def get_courses
    self.get_page.css(".post")
  end

  def make_courses
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css("em").text 
      course.description = post.css("p").text
    end
  end
  #   # find all the elements with class of post within the doc to find all courses
  #   doc.css(".post").each do |post|
  #     # for each course grab the data and instantiate Course objects
  #     course = Course.new
  #     course.title = post.css("h2").text
  #     course.schedule = post.css("em").text 
  #     course.description = post.css("p").text 
  #   end

    #doc.css(".post").first.css("h2").text (extracted the title)
    #doc.css(".post").first.css("em").text (extracted the schedule)
    #doc.css(".post").first.css("p").text (extracted the detail)
 
  
end



