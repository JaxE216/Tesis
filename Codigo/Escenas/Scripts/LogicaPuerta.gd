extends StaticBody2D

class_name Puerta

onready var puertaChiquitaP = get_parent().get_node("PuertaChiquitaP")
onready var puertaChiquitaR = get_parent().get_node("PuertaChiquitaR")
onready var puertaChiquitaD = get_parent().get_node("PuertaChiquitaD")

var tipoPuerta
var abierto = false

func _ready():
	tipoPuerta = get_node(".").name 
	print(tipoPuerta)


func _on_HitBox_body_entered(body):
	if body.name == 'jugador':
		match tipoPuerta:
			'PuertaRoja':
				if body.llaveRoja:
					print('Se puede abrir puerta roja')
					abrirPuerta(get_node("PuertaRed"), get_node("PuertaRedAbierta"), get_node("colisionPuerta"))
					Checkpoints.reaparicion = global_position
					SaveScript.game_data.reaparicion = Checkpoints.reaparicion
					SaveScript.save_data()
					
					if puertaChiquitaR != null:
						puertaChiquitaR.queue_free()
				else:
					print('No se puede abrir puerta roja')
			'PuertaDorada':
				if body.llaveDorada:
					print('Se puede abrir puerta dorada')
					abrirPuerta(get_node("PuertaGold"), get_node("PuertaGoldAbierta"), get_node("colisionPuerta"))
					Checkpoints.reaparicion = global_position
					SaveScript.game_data.reaparicion = Checkpoints.reaparicion
					SaveScript.save_data()
					
					if puertaChiquitaD != null:
						puertaChiquitaD.queue_free()
				else:
					print('No se puede abrir puerta dorada')
			'PuertaPlata':
				if body.llavePlata:
					print('Se puede abrir puerta plata')
					abrirPuerta(get_node("PuertaSilver"), get_node("PuertaSilverAbierta"), get_node("colisionPuerta"))
					Checkpoints.reaparicion = global_position
					SaveScript.game_data.reaparicion = Checkpoints.reaparicion
					SaveScript.save_data()
					
					if puertaChiquitaP != null:
						puertaChiquitaP.queue_free()
				else:
					print('No se puede abrir puerta plata')

func abrirPuerta(puertaCerrada, puertaAbierta, colisionPuerta):
	puertaCerrada.visible = false
	puertaAbierta.visible = true
	colisionPuerta.queue_free()
	
	get_node("HitBox").set_deferred("monitoring", false)
	
	abierto = true
