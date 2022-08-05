extends StaticBody2D

class_name ArbolRama

func get_class():
	return "ArbolRama"

func tirarRama():
	get_node("Rama").ramaTirada()
	get_node("arbolRamaSprite").hide()
	get_node("arbolSprite").show()

func reiniciarArbol():
	get_node("arbolRamaSprite").show()
	get_node("arbolSprite").hide()



func _on_HitBoxArbol_area_entered(area):
	if area.name != 'HitBoxRama' and area.name != 'hurtBoxJugador':
		tirarRama()
