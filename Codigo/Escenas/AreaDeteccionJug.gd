extends Area2D

var jugador = null

func jugadorDetectado():
	return jugador != null

func _on_AreaDeteccionJug_body_entered(body):
	if body.name == 'jugador':
		jugador = body

func _on_AreaDeteccionJug_body_exited(body):
	if body.name == 'jugador':
		jugador = null
