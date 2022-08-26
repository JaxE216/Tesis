extends Node

const SAVEFILE = "res://Savefile.save"

"""
Guardar datos de llaves y puertas para los niveles restantes con la misma
lógica del nivel 1 y 2
"""

var game_data = {}
var level_data = {}

func _ready():
	load_data()

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
		level_data = {
			"Nivel_1" : {
				"Diamante_0_0" : false,
				"Diamante_0_1" : false,
				"Diamante_0_2" : false,
				"LlaveDorada" : false,
				"LlaveRoja" : false,
				"LlavePlata" : false,
				"PuertaChiquitaP" : false,
				"PuertaChiquitaR" : false,
				"PuertaDorada" : false,
				"PuertaRoja" : false,
				"PuertaPlata" : false
			},
			"Nivel_2" : {
				"Diamante_2_0" : false,
				"Diamante_2_1" : false,
				"arbolDiamante_2_2" : false
			}
		}
		save_data()
	file.open(SAVEFILE, File.READ)
	game_data = file.get_var()
	level_data = file.get_var()
	file.close()

func save_data():
	var file = File.new()
	file.open(SAVEFILE, File.WRITE)
	file.store_var(game_data)
	file.store_var(level_data)
	file.close()	

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
	level_data = {
		"Nivel_1" : {
			"Diamante_1_0" : false,
			"Diamante_1_1" : false,
			"Diamante_1_2" : false,
			"LlaveDorada" : false,
			"LlaveRoja" : false,
			"LlavePlata" : false,
			"PuertaChiquitaP" : false,
			"PuertaChiquitaR" : false,
			"PuertaDorada" : false,
			"PuertaRoja" : false,
			"PuertaPlata" : false
		},
		"Nivel_2" : {
			"Diamante_2_0" : false,
			"Diamante_2_1" : false,
			"arbolDiamante_2_2" : false
		}
	}
	file.store_var(game_data)
	file.store_var(level_data)
	file.close()
