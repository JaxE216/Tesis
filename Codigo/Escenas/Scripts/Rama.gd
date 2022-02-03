extends RigidBody2D

class_name Rama

#var banTirada = false

func _ready():
	get_node("CollisionShape2D").disabled = true

func ramaTirada():
	get_node(".").show()
	get_node("CollisionShape2D").disabled = false
	#banTirada = true

func recogerRama():
	get_node(".").get_parent().reiniciarArbol()
	get_node(".").hide()
	get_node("CollisionShape2D").disabled = true
