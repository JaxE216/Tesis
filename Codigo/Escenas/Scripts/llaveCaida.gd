extends Sprite

class_name LlaveCaida

var recogido
var enArbol = false


# hasta acá son experimentos
func recoger():
	print('Llave recogida')
	recogido = true
	get_node(".").queue_free()

func get_class():
	return "Llave"

func _on_HitBox_body_entered(body):
	if !enArbol:
		recoger()
