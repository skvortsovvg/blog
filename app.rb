require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

$db = SQLite3::Database.new 'blog.db'
$db.results_as_hash = true

configure do
  $db.execute("CREATE TABLE IF NOT EXISTS posts
            (
               'id' INTEGER PRIMARY KEY AUTOINCREMENT, 
               'user_id' INTEGER, 
               'create_date' DATE, 
               'content' TEXT
            )")
  $db.execute("CREATE TABLE IF NOT EXISTS comments
            (
               'id' INTEGER PRIMARY KEY AUTOINCREMENT, 
               'post_id' INTEGER, 
               'create_date' DATE, 
               'comment' TEXT
            )")
end

before '/' do
  @results = $db.execute('select * from posts order by id desc limit 5;')
end

get '/' do
  erb :index     
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
    redirect to '/'
  end
end

get '/posts' do
	erb "Posts"
end

get '/posts/:post_id' do
  @results = $db.execute('select * from posts where id = ?', params[:post_id])
  erb :details
end

post '/posts/:post_id' do
  if params[:commenttext].empty? then
    @error = "Введите текст записи!"
    erb :details
  else
    $db.execute('insert into posts (create_date, post_id, comment) values (datetime(),?,?)', [params[:post_id], params[:commenttext]])
    redirect to "/possts/#{params[:post_id]}"
  end
end