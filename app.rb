#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

configure do
  enable :sessions
end

helpers do
  def username
    session[:identity] ? session[:identity] : 'Hello stranger mutherfucker!'
  end
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

before '/visit' do
  unless session[:identity]
    session[:previous_url] = request.path
    @error = 'Sorry, you need to be logged in to visit ' + request.path
    halt erb(:login_form)
  end
end

get '/about' do
	erb :about
end

get '/newpost' do
	erb "Hello. New post"
end

get '/posts' do
	erb "Posts"
end

get '/login/form' do
  @error = ""
  erb :login_form
end

get '/logout' do
  session.delete(:identity)
  session.delete(:pwd)
  erb "<div class='alert alert-message'>Logged out</div>"
end

post '/login/attempt' do
  if params['userpassword'] == 'secret' then
  	session[:identity] = params['username']
	session[:pwd] = params['userpassword']
  	erb :visit
  else
    @error = "Invalid password!"
    erb :login_form
  end

end

post '/visit' do
	input = File.open('.\public\visit.txt', 'a+')
	input.write("#{params[:username]}; #{params[:plantime]}; #{params[:phoneno]}; #{params[:barber]}\n")
	input.close
	erb "Уважаемый #{params[:username]}, данные записаны! Ждем вас в #{params[:plantime]}"
end

post '/contacts' do
	input = File.open('.\public\contacts.txt', 'a+')
	input.write("#{params[:email]}; #{params[:msg]}\r")
	input.close
	erb "Данные отправлены, спасибо за обращение!"
end