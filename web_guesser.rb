require 'sinatra'
require 'sinatra/reloader'

set :secret_number, rand(100)

get '/' do
	message = if params["guess"]
		guess_message(settings.secret_number, params["guess"].to_i)
	else
		"enter a guess"
	end
	erb :index, :locals => {:secret_number => settings.secret_number, :message => message, :guess => params["guess"] }
end

post "/" do
	settings.secret_number = rand(100)
	redirect "/"
end

def guess_message(secret_number, guess)
	if guess - secret_number < -5
		"way too low!"
	elsif guess - secret_number > 5
		"way too high!"
	elsif guess > secret_number
		"too high!"
	elsif guess < secret_number
		"too low!"
	else
		"you got it!"
	end
end
