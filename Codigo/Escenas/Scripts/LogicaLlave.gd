extends Sprite

class_name Llave

var recogido

func _ready():
	recogido = "false"
	print(get_node(".").name)

func recoger(body):
	print(body.name)
	if body.name == 'jugador':
		recogido = "true"
		get_node(".").queue_free()
		
		body.recogerLlave()

func get_class():
	return "Llave"


func _on_HitBoxLlave_body_entered(body):
	recoger(body)
