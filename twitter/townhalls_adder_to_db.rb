require 'twitter'
require 'json'
require 'dotenv'
Dotenv.load

ck = ENV['TWITTER_API_KEY']
cs = ENV['TWITTER_API_SECRET']
at = ENV['TWITTER_TOKEN']
atk = ENV['TWITTER_TOKEN_ACCESS']


CLIENT = Twitter::REST::Client.new do |config|
    config.consumer_key        =ck
    config.consumer_secret     =cs
    config.access_token        =at
    config.access_token_secret =atk
end

# convertir le format json en objet ruby
 def json_to_ruby
    json = File.read('./database/townhalls.json')
    obj = JSON.parse(json)
    return obj
 end


#methode qui recupere les villes
def nom_ville
	nom = []
	json_to_ruby.each do |i| 
	 nom.push(i['name'])
 	end
 	nom
end

# recuperation des nom d'utilisateur dans t[]
def user
        t = []
        ville = nom_ville
		ville.each do |i|
			CLIENT.search(i).take(1).collect do |tweet|
				t.push("#{tweet.user.screen_name}") 

			end
		 end
	return t
end
user

#handle twitter
def handle_twitter
    j = 0
    handle =[]
    user.each do |i|
    handle.push["@#{i}"]
    j +=1
    end
end

def handle
	var = json_to_ruby
	i=0
	var.each do |handle|
		nom_arobage = '@' +user[i]
	        var[i]['handle_twitter'] = nom_arobage
	    i += 1
	end
	return var
end

 File.open("./database/townhallsFinal.json","w") do |f|
     f.write(handle.to_json)
 end