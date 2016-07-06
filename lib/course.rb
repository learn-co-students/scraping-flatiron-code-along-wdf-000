require 'nokogiri'
require 'open-uri'

class Course
  attr_accessor :title, :schedule
  attr_writer :description
  @@courses = []

  def initialize
    save
  end

  def save
    @@courses << self
  end

  def description
    "Learn how to program robots to explore the depths of space. Guest lecturer: The Mars Rover"
  end

  def self.reset_all
    @@courses.clear
  end

  def self.all
    @@courses
  end
    
end