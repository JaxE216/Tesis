extends RigidBody2D

class_name Diamante

var recogido
var enArbol = false

func _ready():
	recogido = "false"
	if get_node(".").get_parent().get_class() == "ArbolDiamante":
		enArbol = true


# hasta acá son experimentos
func recoger():
	print('Diamante recogido')
	recogido = "true"
	get_node(".").queue_free()

func get_class():
	return "Diamante"
