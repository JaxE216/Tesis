extends StaticBody2D

class_name ArbolLlave

var tipo

func _ready():
	match get_node(".").name:
		'arbolLlaveD':
			tipo = 'dorada'
			get_node("LlaveCaidaD").enArbol = true
		'arbolLlaveR':
			tipo = 'roja'
			get_node("LlaveCaidaR").enArbol = true
		'arbolLlaveP':
			tipo = 'plata'
			get_node("LlaveCaidaP").enArbol = true
	


func get_class():
	return "ArbolLlave"

func tirarLlave(llaveCaida, arbolLlave):
	get_node(llaveCaida).show()
	get_node(arbolLlave).hide()
	get_node("ArbolSinLlave").show()
	
	get_node(llaveCaida).enArbol = false
	get_node("HitBoxArbol").queue_free()


func _on_HitBoxArbol_area_entered(area):
	if area.name != 'HitBoxLlave' and area.name != 'hurtBoxJugador':
		match tipo:
			'dorada': 
		#		yield(get_tree().create_timer(0.6), "timeout")
				tirarLlave("LlaveCaidaD", "ArbolLlaveD")
			'roja':
				tirarLlave("LlaveCaidaR", "ArbolLlaveR")
			'plata':
				tirarLlave("LlaveCaidaP", "ArbolLlaveP")
