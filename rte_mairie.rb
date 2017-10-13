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
	##################
	#encore optimisee
	email2 = email2.text.split("\u00A0").select{ |x| x.include?("@")}[0] unless email2.text.split("\u00A0").select{ |x| x.include?("@")}[0].nil? 
	########
	#ou :

	#afin de gerer les adresses vides on fait un || "" pour le retour de find_index
	#return email2.text.split("\u00A0")[email2.text.split("\u00A0").find_index{|x| x.include?("@")} ]
	#essayer avec || "" mais pas reussi

	#binding.pry
end

# page_url = "http://annuaire-des-mairies.com/95/vaureal.html"
# page_url ="http://annuaire-des-mairies.com/95/chatenay-en-france.html"

# puts get_the_email_of_a_townhal_from_its_webpage(page_url)

#récupère toutes les url de villes du Val d'Oise
def get_all_the_urls_of_val_doise_townhalls(page_url)
	page = Nokogiri::HTML(open(page_url))

	url = page.xpath('//a[@class="lientxt"]')

	list_url = []

	url.each do |x|
		list_url << { name:x.text, url:"http://annuaire-des-mairies.com" + x[:href][1..-1] }	
	end

	return list_url

	binding.pry
end

page_url = "http://annuaire-des-mairies.com/val-d-oise.html"

tt= get_all_the_urls_of_val_doise_townhalls(page_url)

townhall_list = []
#
get_all_the_urls_of_val_doise_townhalls(page_url).each do |x|
	#il y avait une erreur de mail non renseigne , vu grace aux instructions ci dessous
	#donc on doit traiter les emails vides : ok fait ds la def de la fonction cidessus
	# puts "--------"
	# puts x[:url]

	email_ville=get_the_email_of_a_townhal_from_its_webpage( x[:url])
	#puts x[:url]

	townhall_list << { :name => x[:name], :email=> email_ville }
end

#on affiche pour check :
townhall_list.each do |x|
	puts x[:name].to_s + " (" + x[:email].to_s + ")"
	puts "----"
end