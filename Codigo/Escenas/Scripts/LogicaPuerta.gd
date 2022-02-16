extends StaticBody2D

var tipoPuerta

func _ready():
	tipoPuerta = get_node(".").name 
	print(tipoPuerta)


func _on_HitBox_body_entered(body):
	if body.name == 'jugador':
		match tipoPuerta:
			'PuertaRoja':
				if body.llaveRoja:
					print('Se puede abrir puerta roja')
				else:
					print('No se puede abrir puerta roja')
			'PuertaDorada':
				if body.llaveDorada:
					print('Se puede abrir puerta dorada')
				else:
					print('No se puede abrir puerta dorada')
			'PuertaPlata':
				if body.llavePlata:
					print('Se puede abrir puerta plata')
				else:
					print('No se puede abrir puerta plata')
