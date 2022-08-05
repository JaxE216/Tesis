extends Node2D

onready var jugador = get_node("jugador")

func _process(delta):
	var colisionJugador = jugador.get_colision()
	var nivel = get_node(".").name
	match jugador.estado:
		jugador.MOVER:
			if colisionJugador is Llave:
				colisionJugador.recoger()
			if colisionJugador is Puerta:
				print(colisionJugador.tipoPuerta)
				
				match nivel:
					'Nivel_1':
						if colisionJugador.tipoPuerta == 'PuertaDorada' and colisionJugador.abierto:
							get_tree().change_scene("res://Niveles/Nivel_2.tscn")
					'Nivel_2':
						if colisionJugador.tipoPuerta == 'PuertaDorada' and colisionJugador.abierto:
							get_tree().change_scene("res://Niveles/Nivel_3.tscn")
					'Nivel_3':
						if colisionJugador.tipoPuerta == 'PuertaRoja' and colisionJugador.abierto:
							get_tree().change_scene("res://Niveles/Nivel_4.tscn")
					'Nivel_4':
						if colisionJugador.tipoPuerta == 'PuertaRoja' and colisionJugador.abierto:
							get_tree().change_scene("res://Niveles/Nivel_5.tscn")
					'Nivel_5':
						if colisionJugador.tipoPuerta == 'PuertaRoja' and colisionJugador.abierto:
							get_tree().change_scene("res://Niveles/Nivel_6.tscn")
					'Nivel_6':
						if colisionJugador.tipoPuerta == 'PuertaRoja' and colisionJugador.abierto:
							get_tree().change_scene("res://Niveles/Nivel_7.tscn")
					'Nivel_7':
						if colisionJugador.tipoPuerta == 'PuertaDorada' and colisionJugador.abierto:
							get_tree().change_scene("res://Niveles/Nivel_8.tscn")
					'Nivel_8':
						if colisionJugador.tipoPuerta == 'PuertaPlata' and colisionJugador.abierto:
							get_tree().change_scene("res://Niveles/Nivel_9.tscn")
		jugador.ATACAR:
			pass
#			if colisionJugador is ArbolDiamante:
#				colisionJugador.tirarDiamante()
#			if colisionJugador is ArbolRama:
#				colisionJugador.tirarRama()
