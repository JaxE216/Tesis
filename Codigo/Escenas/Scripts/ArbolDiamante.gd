extends StaticBody2D

class_name ArbolDiamante

func _ready():
	get_node("DiamanteCaido").enArbol = true


func get_class():
	return "ArbolDiamante"

func tirarDiamante():
	get_node("DiamanteCaido").show()
	get_node("ArbolDiamante").hide()
	get_node("ArbolSinDiamante").show()
	
	get_node("DiamanteCaido").enArbol = false
	get_node("HitBoxArbol").queue_free()


func _on_HitBoxArbol_area_entered(area):
	if area.name != 'HitBoxDiamante' and area.name != 'hurtBoxJugador':
		tirarDiamante()
