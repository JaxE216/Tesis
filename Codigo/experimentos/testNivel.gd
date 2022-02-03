extends Node2D

#func _ready():
#	print("Estado diamante: " + diamante.recogido)	

onready var jugador = get_node("jugador")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	get_node("DiamanteCaido").recoger()
	var colisionJugador = jugador.get_colision()
	#print(colisionJugador)
	match jugador.estado:
		jugador.MOVER:
			if colisionJugador is Diamante:
				#jugador.banArmado = true
				colisionJugador.queue_free()
			if colisionJugador is Rama:
				colisionJugador.recogerRama()
				jugador.armarJugador()
		jugador.ATACAR:
			if colisionJugador is ArbolDiamante:
				colisionJugador.tirarDiamante()
			if colisionJugador is ArbolRama:
				colisionJugador.tirarRama()
	
