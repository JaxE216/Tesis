extends StaticBody2D

class_name ArbolDiamante

#func _ready():
#	get_node("DiamanteCaido/CollisionShape2D").disabled = true
#	print(get_node("DiamanteCaido/CollisionShape2D").disabled)

func get_class():
	return "ArbolDiamante"

func tirarDiamante():
	get_node("DiamanteCaido").show()
	get_node("DiamanteCaido/CollisionShape2D").disabled = false
	get_node("ArbolDiamante").hide()
	get_node("ArbolSinDiamante").show()
	get_node("DiamanteCaido").enArbol = false

func _on_Hurtbox_area_entered(area):
	tirarDiamante()
	print(area)
