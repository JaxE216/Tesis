extends RigidBody2D

class_name Llave

var recogido

func _ready():
	recogido = "false"
	print(get_node(".").name)

func recoger():
	recogido = "true"
	get_node(".").queue_free()

func get_class():
	return "Llave"
