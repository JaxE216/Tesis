extends StaticBody2D

class_name BotonPuente

onready var tipoPuente = get_parent()

func _on_HitBox_area_entered(area):
	if area.name != 'hurtBoxJugador':
		print('Golpeó el botón')
		presionarBoton()
		
		if tipoPuente.get_parent().name != "Nivel_4":
			# Espera 5 segundos y luego vuelve a desaparecer el puente
			yield(get_tree().create_timer(5), "timeout")
			
			levantarBoton()

func presionarBoton():
	get_node("BotonInicial").hide()
	get_node("BotonFinal").show()
	
	print(tipoPuente.name)
	match tipoPuente.name:
		'PuenteHorizontal_CM':
			tipoPuente.habilitarPuenteH(true)
		'PuenteVertical_CM':
			tipoPuente.habilitarPuenteV(true)

func levantarBoton():
	get_node("BotonInicial").show()
	get_node("BotonFinal").hide()
	
	match tipoPuente.name:
		'PuenteHorizontal_CM':
			tipoPuente.habilitarPuenteH(false)
		'PuenteVertical_CM':
			tipoPuente.habilitarPuenteV(false)
