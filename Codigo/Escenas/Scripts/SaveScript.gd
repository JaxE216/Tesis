extends Node

const SAVEFILE = "res://Savefile.save"

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
				"arbolDiamante_2_2" : false,
				"LlaveDorada" : false,
				"LlaveRoja" : false,
				"LlavePlata" : false,
				"PuertaChiquitaP" : false,
				"PuertaChiquitaR" : false,
				"PuertaDorada" : false,
				"PuertaRoja" : false,
				"PuertaPlata" : false
			},
			"Nivel_3" : {
				"Diamante_3_0" : false,
				"Diamante_3_1" : false,
				"arbolDiamante_3_2" : false,
				"arbolDiamante_3_3" : false,
				"LlaveDorada" : false,
				"LlaveRoja" : false,
				"LlavePlata" : false,
				"PuertaChiquitaP" : false,
				"PuertaChiquitaD" : false,
				"PuertaDorada" : false,
				"PuertaRoja" : false,
				"PuertaPlata" : false
			},
			"Nivel_4" : {
				"Diamante_4_0" : false,
				"Diamante_4_1" : false,
				"arbolDiamante_4_2" : false,
				"LlaveDorada" : false,
				"LlaveRoja" : false,
				"LlavePlata" : false,
				"PuertaChiquitaP" : false,
				"PuertaChiquitaD" : false,
				"PuertaDorada" : false,
				"PuertaRoja" : false,
				"PuertaPlata" : false
			},
			"Nivel_5" : {
				"arbolDiamante_5_0" : false,
				"Diamante_5_1" : false,
				"arbolDiamante_5_2" : false,
				"LlaveDorada" : false,
				"LlavePlata" : false,
				"arbolLlaveD" : false,
				"PuertaChiquitaP" : false,
				"PuertaChiquitaD" : false,
				"PuertaDorada" : false,
				"PuertaRoja" : false,
				"PuertaPlata" : false
			},
			"Nivel_6" : {
				"arbolDiamante_6_0" : false,
				"arbolDiamante_6_1" : false,
				"arbolDiamante_6_2" : false,
				"Diamante_6_3" : false,
				"LlaveDorada" : false,
				"LlavePlata" : false,
				"arbolLlaveD" : false,
				"PuertaChiquitaP" : false,
				"PuertaChiquitaD" : false,
				"PuertaDorada" : false,
				"PuertaRoja" : false,
				"PuertaPlata" : false
			},
			"Nivel_7" : {
				"arbolDiamante_7_0" : false,
				"arbolDiamante_7_1" : false,
				"arbolDiamante_7_2" : false,
				"Diamante_7_3" : false,
				"LlaveDorada" : false,
				"LlavePlata" : false,
				"arbolLlaveD" : false,
				"PuertaChiquitaP" : false,
				"PuertaChiquitaD" : false,
				"PuertaDorada" : false,
				"PuertaRoja" : false,
				"PuertaPlata" : false
			},
			"Nivel_8" : {
				"arbolDiamante_8_0" : false,
				"arbolDiamante_8_1" : false,
				"arbolDiamante_8_2" : false,
				"arbolDiamante_8_3" : false,
				"arbolDiamante_8_4" : false,
				"LlaveDorada" : false,
				"LlavePlata" : false,
				"arbolLlaveD" : false,
				"PuertaChiquitaP" : false,
				"PuertaChiquitaD" : false,
				"PuertaDorada" : false,
				"PuertaRoja" : false,
				"PuertaPlata" : false
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
			"arbolDiamante_2_2" : false,
			"LlaveDorada" : false,
			"LlaveRoja" : false,
			"LlavePlata" : false,
			"PuertaChiquitaP" : false,
			"PuertaChiquitaR" : false,
			"PuertaDorada" : false,
			"PuertaRoja" : false,
			"PuertaPlata" : false
		},
		"Nivel_3" : {
			"Diamante_3_0" : false,
			"Diamante_3_1" : false,
			"arbolDiamante_3_2" : false,
			"arbolDiamante_3_3" : false,
			"LlaveDorada" : false,
			"LlaveRoja" : false,
			"LlavePlata" : false,
			"PuertaChiquitaP" : false,
			"PuertaChiquitaD" : false,
			"PuertaDorada" : false,
			"PuertaRoja" : false,
			"PuertaPlata" : false
		},
		"Nivel_4" : {
			"Diamante_4_0" : false,
			"Diamante_4_1" : false,
			"arbolDiamante_4_2" : false,
			"LlaveDorada" : false,
			"LlaveRoja" : false,
			"LlavePlata" : false,
			"PuertaChiquitaP" : false,
			"PuertaChiquitaD" : false,
			"PuertaDorada" : false,
			"PuertaRoja" : false,
			"PuertaPlata" : false
		},
		"Nivel_5" : {
			"arbolDiamante_5_0" : false,
			"Diamante_5_1" : false,
			"arbolDiamante_5_2" : false,
			"LlaveDorada" : false,
			"LlavePlata" : false,
			"arbolLlaveD" : false,
			"PuertaChiquitaP" : false,
			"PuertaChiquitaD" : false,
			"PuertaDorada" : false,
			"PuertaRoja" : false,
			"PuertaPlata" : false
		},
		"Nivel_6" : {
			"arbolDiamante_6_0" : false,
			"arbolDiamante_6_1" : false,
			"arbolDiamante_6_2" : false,
			"Diamante_6_3" : false,
			"LlaveDorada" : false,
			"LlavePlata" : false,
			"arbolLlaveD" : false,
			"PuertaChiquitaP" : false,
			"PuertaChiquitaD" : false,
			"PuertaDorada" : false,
			"PuertaRoja" : false,
			"PuertaPlata" : false
		},
		"Nivel_7" : {
			"arbolDiamante_7_0" : false,
			"arbolDiamante_7_1" : false,
			"arbolDiamante_7_2" : false,
			"Diamante_7_3" : false,
			"LlaveDorada" : false,
			"LlavePlata" : false,
			"arbolLlaveD" : false,
			"PuertaChiquitaP" : false,
			"PuertaChiquitaD" : false,
			"PuertaDorada" : false,
			"PuertaRoja" : false,
			"PuertaPlata" : false
		},
		"Nivel_8" : {
			"arbolDiamante_8_0" : false,
			"arbolDiamante_8_1" : false,
			"arbolDiamante_8_2" : false,
			"arbolDiamante_8_3" : false,
			"arbolDiamante_8_4" : false,
			"LlaveDorada" : false,
			"LlavePlata" : false,
			"arbolLlaveD" : false,
			"PuertaChiquitaP" : false,
			"PuertaChiquitaD" : false,
			"PuertaDorada" : false,
			"PuertaRoja" : false,
			"PuertaPlata" : false
		}
	}
	file.store_var(game_data)
	file.store_var(level_data)
	file.close()
