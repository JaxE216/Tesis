extends Node2D


onready var jugador = get_node("jugador")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	get_node("DiamanteCaido").recoger()
	var colisionJugador = jugador.get_colision()
	match jugador.estado:
		jugador.MOVER:
			if colisionJugador is Llave:
				colisionJugador.recoger()
			if colisionJugador is Rama:
				#if colisionJugador.banTirada == true:
				colisionJugador.recogerRama()
				jugador.armarJugador()
		jugador.ATACAR:
#			if colisionJugador is ArbolDiamante:
#				colisionJugador.tirarDiamante()
			if colisionJugador is ArbolRama:
				colisionJugador.tirarRama()
