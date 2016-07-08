require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  
  def get_page
    flatiron_courses = open("http://learn-co-curriculum.github.io/site-for-scraping/courses")
    page_doc = Nokogiri::HTML(flatiron_courses)
  end

  def get_courses
    course_node_set = get_page.css(".post")
  end

  def make_courses
    get_courses.each do |course|
      if course.css("h2").text != ""
        new_course = Course.new
        new_course.title = course.css("h2").text
        new_course.schedule = course.css("em").text
        new_course.description = course.css("p").text
      end
    end
  end

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "  Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end

# Scraper.new.print_courses