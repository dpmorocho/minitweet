require 'json'
Usuarios = {"Nombre" => "Diego", "Apellido" => "Morocho"}
File.open("ejer.json", "w") do |f|
		f.write (Usuarios.to_json)
end