#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri' 
require 'open-uri'
require 'pry'

#récupère l'adresse email à partir de l'url d'une mairie

def get_the_email_of_a_townhal_from_its_webpage(page_url)

	page = Nokogiri::HTML(open(page_url))

	#.gsub("\u00A0", "") est utilise pour supprimer non bracing space in ruby
	# email = page.css("td p.Style22")[11].text.gsub("\u00A0", "")
	#delete("\s") .gsub(/\s+/, "")

	#pour trouver index du mot contenant @
	# cpt=0
	# email.each do |indexxxxx|
	# 	puts cpt
	# 	puts email[cpt]
	# 	cpt +=1
	# 	puts "----------------------"
	# end
	# test autre methode : KO pour l'instant
	# tab=page.css("td p.Style22")
	# tab.each_index.select{|i| tab[i] == '@'}

	#puts email
	# puts "----- avec xpath-----"
	email2 = page.xpath('//td[@class="style27"]/p[@class="Style22"]')

	# puts toto=email2.select{ |x| x.text.include?("@")}

	#solution un peu stylee !! fier de moi ! lol
	# email2=email2.text.gsub("\u00A0", "|").split('|').select{ |x| x.include?("@")}[0]
	#encore optimisee
	email2 = email2.text.split("\u00A0").select{ |x| x.include?("@")}[0]

	#binding.pry
end

page_url = "http://annuaire-des-mairies.com/95/vaureal.html"

puts get_the_email_of_a_townhal_from_its_webpage(page_url)