require 'sinatra'
require './lookups'
require 'rdiscount'

get '/' do
  haml :index
end

[:recipe, :menu].each do |resource|
  get "/#{resource}/:template" do
    markdown params[:template].to_sym, { :views => "#{resource}s" }
  end
  
  get "/edit/#{resource}/:name" do |name|
    edit = IO.read "#{resource}s/#{name}.md"
    haml :edit, :locals => { :name => name, :edit => edit }
  end

  post "/edit/#{resource}/" do
    File.open("#{resource}s/#{params[:name]}.md",'w') do |f|
      f.puts params[:edit]
    end
    redirect "#{resource}/#{params[:name]}"
  end
end
