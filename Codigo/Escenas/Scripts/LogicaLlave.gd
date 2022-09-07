extends Sprite

class_name Llave

var enArbol

var tipoLlave

func _ready():
	enArbol = false
	tipoLlave = get_node(".").name

func recoger(body):
	if body.name == 'jugador':
		Checkpoints.reaparicion = global_position
		
		if 'Nivel' in get_node(".").get_parent().name:
			SaveScript.level_data[get_node(".").get_parent().name][get_node(".").name] = true
		else:
			SaveScript.level_data[get_node(".").get_parent().get_parent().name][get_node(".").get_parent().name] = true
		
		body.recogerLlave(tipoLlave)
		
		enArbol = true
		get_node(".").queue_free()

func get_class():
	return "Llave"


func _on_HitBoxLlave_body_entered(body):
	if !enArbol:
		recoger(body)
