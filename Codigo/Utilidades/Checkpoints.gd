extends Node

var reaparicion = null
var cont_diamantes = 0
var ban_llaveR = false
var ban_llaveD = false
var ban_llaveP = false

func _ready():
	SaveScript.load_data()
	
	reaparicion = SaveScript.game_data["reaparicion"]
	cont_diamantes = SaveScript.game_data.cont_diamantes
	ban_llaveR = SaveScript.game_data.ban_llaveR
	ban_llaveD = SaveScript.game_data.ban_llaveD
	ban_llaveP = SaveScript.game_data.ban_llaveP

func vaciarDatos():
	reaparicion = null
	ban_llaveR = false
	ban_llaveD = false
	ban_llaveP = false
