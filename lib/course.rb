require 'nokogiri'
require 'open-uri'

class Course
  attr_accessor :title, :schedule, :description
  @@courses = []

  def initialize
    save
  end

  def save
    @@courses << self
  end

  def self.reset_all
    @@courses.clear
  end

  def self.all
    @@courses
  end
    
end