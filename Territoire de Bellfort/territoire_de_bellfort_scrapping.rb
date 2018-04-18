require 'nokogiri'
require 'rubygems'
require 'open-uri'
require 'csv'
require 'json'


# voici la methode pour scrapper l'addresse mail d'une ville a partir de son url x
def get_the_email_of_a_townhal_from_its_webpage(x)
    doc = Nokogiri::HTML(open(x))
    doc.css('.tr-last')[3].text.split(" ")[2]
end

# un tableau vide ou je vais stocker les urls de chaque mairie
Tab_url = []

# La methode pour scrapper tous les urls de chaque mairie
def get_all_the_urls_of_territoire_de_bellfort_townhalls(x)
    doc = Nokogiri::HTML(open(x))
    doc.css('.lientxt').each do |url|
        Tab_url.push("http://annuaire-des-mairies.com" + (url["href"][1..-1]))
    end
    Tab_url
end


=begin 
Une derniere methode appelé scrapping
Appel du premier methode dans chaque url de chaque mairie et pusher tous les valeurs dans tableau_final
Et aussi recuperation du nom de chaque mairie et le mettre dans tableau_final
=end
def scrapping
 tableau_final = []
 t = get_all_the_urls_of_territoire_de_bellfort_townhalls("http://annuaire-des-mairies.com/territoire-de-belfort.html")
    t.each do |i|
        tableau_final.push({
            :name => Nokogiri::HTML(open(i)).css('main h1')[0].text.split(" ")[0],
            :email => get_the_email_of_a_townhal_from_its_webpage(i)
        })
    end
    tableau_final
end

var = scrapping


File.open("territoire_de_bellfort.json","w") do |f|
    f.write(var.to_json)
end