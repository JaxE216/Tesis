extends KinematicBody2D

class_name enemigo

enum {
	QUIETO,
	PERSEGUIR
}

var velocidad = Vector2.ZERO
var saludEnemigo = 100
var estado = QUIETO

var posJugador = Vector2.ZERO
onready var areaDeteccionJug = $AreaDeteccionJug
onready var vectorPosInicialEnemigo = global_position
onready var vectorPosEnemigo = Vector2.ZERO

func _physics_process(delta):
	vectorPosEnemigo = vectorPosEnemigo.move_toward(Vector2.ZERO, 200 * delta)
	buscarJugador()
	
	match estado:
		QUIETO:
			if global_position.distance_to(vectorPosInicialEnemigo) >= 0 and global_position.distance_to(vectorPosInicialEnemigo) <= 0.5:
				velocidad = Vector2.ZERO
			else:
				var direccion = (vectorPosInicialEnemigo - global_position).normalized()
				
				velocidad = direccion * 40
			
		PERSEGUIR:
			var jugador = areaDeteccionJug.jugador
			
			if jugador != null:
				var direccion = (jugador.global_position - global_position).normalized()
				
				velocidad = direccion * 30
			
	vectorPosEnemigo = move_and_slide(vectorPosEnemigo)
	velocidad = move_and_slide(velocidad)
		
func _on_HitBox_area_entered(area):
	match area.name:
		'areaGolpeoCA':
			saludEnemigo = saludEnemigo - 50
			vectorPosEnemigo = area.vector_direccionGolpe * 110
		'areaGolpeoSA':
			saludEnemigo = saludEnemigo - 25
			vectorPosEnemigo = area.vector_direccionGolpe * 95
	
	if saludEnemigo <= 0:
		get_node(".").queue_free()

func buscarJugador():
	if areaDeteccionJug.jugadorDetectado():
		estado = PERSEGUIR
	else:
		estado = QUIETO

