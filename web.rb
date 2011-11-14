require 'sinatra'
require './lookups'

get '/' do
  haml :index
end

get '/recipe/:template' do
  markdown params[:template].to_sym, { :views => 'recipes' }
end

get '/menu/:template' do
  markdown params[:template].to_sym, { :views => 'menus' }
end

get '/edit/recipe/:name' do |name|
  edit = IO.read "recipes/#{name}.md"
  haml :edit, :locals => { :name => name, :edit => edit }
end

get '/edit/menu/:name' do |name|
  edit = IO.read "menus/#{name}.md"
  haml :edit, :locals => { :name => name, :edit => edit }
end

post '/edit/recipe/' do
  File.open("recipes/#{params[:name]}.md",'w') do |f|
    f.print params[:edit]
  end
  redirect "recipe/#{params[:name]}"
end

post '/edit/menu/' do
  File.open("menus/#{params[:name]}.md",'w') do |f|
    f.puts params[:edit]
  end
  redirect "menu/#{params[:name]}"
end
