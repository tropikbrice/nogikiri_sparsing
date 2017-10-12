require 'rubygems'
require 'nokogiri' 
require 'open-uri'
require 'pr'

PAGE_URL = "http://ruby.bastardsbook.com/files/hello-webpage.html"

page = Nokogiri::HTML(open(PAGE_URL))   
#puts page.class   # => Nokogiri::HTML::Document

puts page.css('title')
puts "------------------------"


ttt= page.css("li")
puts ttt
