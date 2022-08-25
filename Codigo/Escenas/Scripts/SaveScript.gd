extends Node

const SAVEFILE = "res://Savefile.save"

var game_data = {}

func _ready():
	load_data()
	print(game_data)

func load_data():
	var file = File.new()
	if not file.file_exists(SAVEFILE):
		game_data = {
			"nivel" : "Nivel_1.tscn",
			"cont_diamantes" : 0,
			"ban_llaveR" : false,
			"ban_llaveD" : false,
			"ban_llaveP" : false,
			"reaparicion" : null
		}
		save_data()
	file.open(SAVEFILE, File.READ)
	game_data = file.get_var()
	file.close()

func save_data():
	var file = File.new()
	file.open(SAVEFILE, File.WRITE)
	file.store_var(game_data)
	file.close()
	
	print('Guardado: ' + str(game_data))

func delete_data():
	var file = File.new()
	file.open(SAVEFILE, File.WRITE)
	game_data = {
		"nivel" : "Nivel_1.tscn",
		"cont_diamantes" : 0,
		"ban_llaveR" : false,
		"ban_llaveD" : false,
		"ban_llaveP" : false,
		"reaparicion" : null
	}
	file.store_var(game_data)
	file.close()
	
	print('Eliminado: ' + str(game_data))
