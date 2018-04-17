require 'json'
require 'gmail'
require 'dotenv'
Dotenv.load


#connexion gmail

def send_email_to_line(adresse, name)
#N'oubliez pas de créer et d'ajouter vos clés dans .env	
mail = ENV['GOOGLE_API_GMAIL']
pass = ENV['GOOGLE_API_PASS']

gmail = Gmail.connect(mail,pass)

gmail.deliver do
  to "#{adresse}"
  subject "Théophile Coutaind"
  text_part do
    body "Text of plaintext message."
  end
  html_part do
    content_type 'text/html; charset=UTF-8'
    body "Bonjour,<br>
    Je m'appelle Théophile Coutaind, je suis élève à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection,
    sans restriction géographique. La pédagogie de ntore école est celle du peer-learning, où nous travaillons par petits groupes
    sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies
    pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous. <br>
    <p> Déjà 300 personnes sont passées par The Hacking Project. Est-ce que la mairie de #{name} veut changer le monde avec nous ? <br>
    Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80 </p>"
  end
end

gmail.logout

end

def go_through_all_line
#on lit le fichier json
    file = File.read('./database/townhalls.json')
#on parse le fichier
    datas = JSON.parse(file)
#voila le code qui parcours le fichier Json et son contenu plus précisement les emails
        for i in 0...datas.length 
            send_email_to_line(datas[i]['email'], datas[i]['name'])
        end
        #puts datas[i]['email']
end


go_through_all_line