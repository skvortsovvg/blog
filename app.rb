require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

$db = SQLite3::Database.new 'blog.db'

configure do
  $db.execute("CREATE TABLE IF NOT EXISTS posts
            (
               'id' INTEGER PRIMARY KEY AUTOINCREMENT, 
               'user_id' INTEGER, 
               'create_date' DATE, 
               'content' TEXT
            )")
end

before '/visit' do

end

get '/' do
  erb "Ссылка на базу: #{@db}"#{}"Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"     
end

get '/about' do
	erb :about
end

get '/newpost' do
	erb :new
end

post '/newpost' do
  if params[:posttext].empty? then
    @error = "Введите текст записи!"
    erb :new
  else
    $db.execute('insert into posts (create_date, content) values (datetime(),?)', [params[:posttext]])
    erb '/'
  end
end

get '/posts' do
	erb "Posts"
end