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

#func _on_HitBox_body_entered(body):
#	if body.get_class() != 'ArbolDiamante':
#		tirarDiamante()
	


func _on_HitBoxArbol_area_entered(area):
	if area.name != 'HitBoxDiamante':
#		yield(get_tree().create_timer(0.6), "timeout")
		tirarDiamante()
