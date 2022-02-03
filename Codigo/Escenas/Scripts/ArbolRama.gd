extends StaticBody2D

class_name ArbolRama

func tirarRama():
	get_node("Rama").ramaTirada()
	get_node("arbolRamaSprite").hide()
	get_node("arbolSprite").show()

func reiniciarArbol():
	get_node("arbolRamaSprite").show()
	get_node("arbolSprite").hide()
