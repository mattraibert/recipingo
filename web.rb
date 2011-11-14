require 'sinatra'

def strip_suffix filename
  filename.sub(/\.\w*\Z/,'')
end

def files_in folder
  files = Dir.chdir(folder) do
    Dir.glob("*").map {|filename| strip_suffix filename }
  end
end

get '/' do
  haml :index
end

get '/recipe/:template' do
  markdown params[:template].to_sym, { :views => 'recipes' }
end

get '/menu/:template' do
  markdown params[:template].to_sym, { :views => 'menus' }
end
