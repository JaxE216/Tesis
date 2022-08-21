extends AnimatedSprite

class_name Diamante

var recogido
var enArbol = false


# hasta acá son experimentos
func recoger():
	print('Diamante recogido')
	recogido = true
	Checkpoints.reaparicion = global_position
	
	SaveScript.game_data.reaparicion = Checkpoints.reaparicion
	SaveScript.game_data.cont_diamantes = Checkpoints.cont_diamantes
	SaveScript.save_data()
	
	get_node(".").queue_free()

func get_class():
	return "Diamante"

func _on_HitBoxDiamante_area_entered(area):
	print(area.name)
	if area.name == 'hurtBoxJugador':
		recoger()
