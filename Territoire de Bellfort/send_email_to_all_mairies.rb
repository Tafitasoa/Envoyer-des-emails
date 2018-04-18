require 'csv'


def send_mail_to_line(addresse, name)
  require 'gmail'
  gmail = Gmail.connect('rakotocedric10@gmail.com', 'hahaha1234!') 

  email = gmail.compose do
    to "#{addresse}"
    subject "A propos de THP"
    body "Bonjour,
    Je m'appelle [PRÉNOM], je suis élève à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique. La pédagogie de ntore école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.
    
    Déjà 300 personnes sont passées par The Hacking Project. Est-ce que la mairie de [NOM_COMMUNE] veut changer le monde avec nous ?
    
    
    Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80 "
  
  end
email.deliver!
gmail.logout
end

def go_through_all_line
  email_list = CSV.read('territoire_de_bellfort.csv')
  for i in 0...email_list.length
    send_mail_to_line(email_list[i][1], email_list[i][0])
  end
end

go_through_all_line