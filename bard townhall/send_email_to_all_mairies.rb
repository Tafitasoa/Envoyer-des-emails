require 'csv'


def send_mail_to_line(addresse, name)
  require 'gmail'
  gmail = Gmail.connect('rakotocedric10@gmail.com', 'hahaha1234!') 

  gmail.deliver do
    to "#{addresse}"
    subject "A propos de The Hacking Project"
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
  email_list = CSV.read('gard.csv')
  for i in 0...email_list.length
    send_mail_to_line(email_list[i][1], email_list[i][0])
  end
end

go_through_all_line