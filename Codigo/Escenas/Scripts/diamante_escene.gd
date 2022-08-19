extends AnimatedSprite

class_name Diamante

var recogido
var enArbol = false


# hasta acá son experimentos
func recoger():
	print('Diamante recogido')
	recogido = true
	Checkpoints.reaparicion = global_position
	
	get_node(".").queue_free()

func get_class():
	return "Diamante"

func _on_HitBoxDiamante_area_entered(area):
	print(area.name)
	if area.name == 'hurtBoxJugador':
		recoger()
