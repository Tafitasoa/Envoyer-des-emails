require 'dotenv'

puts "Ca va etre un peut long, donc attendez un peu!!!!"
#on appelle le fichier townhalls_scrapper qui insert les fichiers json et il va crée le fichier townhall.json dans database
require_relative "./scrapper/townhalls_scrapper"

puts "Le fichier .json est enregistée"
puts "Maintenant on va envoyer on va envoyer les mails"
#puis on envoye les emails via townhall par rapport au nom indiqué dans townhall.json

require_relative "./mailer/townhalls_mailer"
puts "Mail envoyer!!!!!"
puts "Puis en va follower sur tweeter sur le nom des villes trouver"
puts "Merci de patientez encore un peu!!!!!"


#puis recupere tous les du villes et les follow
require_relative "./twitter/townhalls_follower"

puts "Merci de votre patience!!!!!"