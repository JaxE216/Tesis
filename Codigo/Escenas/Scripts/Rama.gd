extends Sprite

class_name Rama

#var banTirada = false

func _ready():
	get_node(".").hide()
	get_node("HitBoxRama").set_deferred("monitoring", false)

func ramaTirada():
	get_node(".").show()
	get_node("HitBoxRama").set_deferred("monitoring", true)
	#banTirada = true

func recogerRama():
	get_node(".").get_parent().reiniciarArbol()
	get_node(".").hide()
	get_node("HitBoxRama").set_deferred("monitoring", false)
	
	print('Rama recogida')
#	get_node("CollisionShape2D").disabled = true


func _on_HitBoxRama_body_entered(body):
	if body.get_class() != 'ArbolRama':
		recogerRama()
		body.armarJugador()
