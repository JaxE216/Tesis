extends Sprite

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


func _on_HitBoxLlave_body_entered(body):
	recoger()
