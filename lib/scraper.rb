require 'nokogiri'
require 'open-uri'
require "pry"

require_relative './course.rb'

class Scraper

    def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
        puts
      end
    end
  end

  # Resposible for just getting the HTML document
  def get_page
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))

    # doc.css(".post").each do |post|
    #   course = Course.new
    #   course.title = post.css("h2").text
    #   course.schedule = post.css(".date").text
    #   course.description = post.css("p").text
    # end
  end

  # Operates on return value of .get_page and returns collection of Nokogiri XML
  # elements that describe each course
  def get_courses
    self.get_page.css(".post")
  end

  # Operates on the return of .get_courses.
  # Iterate over the collection and create new instance of Course for each,
  # assigning the appropriate attributes
  def make_courses
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
  end

end

Scraper.new.print_courses
