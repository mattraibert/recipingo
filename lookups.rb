def strip_suffix filename
  filename.sub(/\.\w*\Z/,'')
end

def files_in folder
  files = Dir.chdir(folder) do
    Dir.glob("*").map {|filename| strip_suffix filename }
  end
end

def recipes
  files_in "recipes"
end

def menus
  files_in "menus"
end