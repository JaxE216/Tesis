extends AnimatedSprite

class_name Diamante

var recogido
var enArbol = false


# hasta acá son experimentos
func recoger():
	print('Diamante recogido')
	recogido = true
	get_node(".").queue_free()

func get_class():
	return "Diamante"

func _on_HitBox_body_entered(body):
	if !enArbol:
		recoger()
