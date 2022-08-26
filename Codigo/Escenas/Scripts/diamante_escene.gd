extends AnimatedSprite

class_name Diamante

var recogido
var enArbol = false

func recoger():
	print('Diamante recogido')
	recogido = true
	Checkpoints.reaparicion = global_position
	
	SaveScript.game_data.reaparicion = Checkpoints.reaparicion
	SaveScript.game_data.cont_diamantes = Checkpoints.cont_diamantes
	
	if 'Nivel' in get_node(".").get_parent().name:
		SaveScript.level_data[get_node(".").get_parent().name][get_node(".").name] = true
	else:
		SaveScript.level_data[get_node(".").get_parent().get_parent().name][get_node(".").get_parent().name] = true
	
	SaveScript.save_data()
	
	get_node(".").queue_free()

func get_class():
	return "Diamante"

func _on_HitBoxDiamante_area_entered(area):
	print(area.name)
	if area.name == 'hurtBoxJugador':
		recoger()
