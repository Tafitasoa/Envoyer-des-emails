require 'google_drive'
require 'nokogiri'
require 'open-uri'
require 'json'


#collect le departement
def get_departement(url,i)
  doc = Nokogiri::HTML(open(url))
  return doc.css('.lientxt')[i].text.split(" ")[2].downcase # prendre le nom du departement
end

# collecte les mail 
def get_the_email_of_a_townhal_from_its_webpage(url)
  doc = Nokogiri::HTML(open(url))
  return doc.css('.tr-last')[3].text.split(" ")[2]
end

# collecte les urls dans un departement
def get_all_the_urls_of_val_doise_townhalls(departement)
  lien_dep = 'http://annuaire-des-mairies.com/'+departement+'.html'
  #puts lien_dep
  doc = Nokogiri::HTML(open(lien_dep))
  lien = []
  doc.css('.lientxt').each do |val|  
    mail = val["href"][1..-1]
    link = "http://annuaire-des-mairies.com" + mail
    lien << link 

  end
  return lien

end 

# take the name of the country
def nom_ville(departement)
  lien_dep = 'http://annuaire-des-mairies.com/'+departement+'.html'
  nomvilletab = []
  doc = Nokogiri::HTML(open(lien_dep))
  doc.css('.lientxt').each do |val|
    nomville = val.text
    nomvilletab << nomville
  end
  return nomvilletab 
end


def vill_email(departement)
  tabhas = []
  i = 0
  get_all_the_urls_of_val_doise_townhalls(departement).each do |url| 
    tabhas.push({
      :name => nom_ville(departement)[i],
      :email => get_the_email_of_a_townhal_from_its_webpage(url),
      :departement => departement.capitalize
    })
    i += 1
  end
  return tabhas
end

# recuperer les 3 departements
var_json = []
meurthe_et_moselle = get_departement("http://annuaire-des-mairies.com/",18) 
cantal = get_departement("http://annuaire-des-mairies.com/",15)  
gard = get_departement("http://annuaire-des-mairies.com/",30) 

vill_email(cantal).each do |item|
  var_json << item
end
vill_email(gard).each do |item|
  var_json << item
end
vill_email(meurthe_et_moselle).each do |item|
  var_json << item
end


#FICHIER JSON 
File.open("./database/townhalls.json","w") do |f|
     f.write(var_json.to_json)
end
