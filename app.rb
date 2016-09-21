#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

configure do
end

before '/visit' do
end

get '/' do
  erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"     
end

get '/about' do
	erb :about
end

get '/newpost' do
	erb :new
end

post '/newpost' do
  erb params[:posttext]
end

get '/posts' do
	erb "Posts"
end