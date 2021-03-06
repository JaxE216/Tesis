extends KinematicBody2D

class_name JugadorTest

const VEL_MAX = 200

enum {
	MOVER,
	ATACAR
}

var velocidad = Vector2.ZERO
var estado = MOVER
var banArmado = false
var saludRama
var colisionando = false
var ultimo_arbolRama_tocado
var ultimo_arbolDiamante_tocado

onready var animacion = $AnimationPlayer
onready var arbolAnimacion = $AnimationTree
onready var estadoAnimacion = arbolAnimacion.get("parameters/playback")

func _ready():
	arbolAnimacion.active = true

func _physics_process(delta):
	match estado:
		MOVER:
			estado_mover(delta)
		
		ATACAR:
			estado_atacar(delta, banArmado)

func estado_mover(delta):
	var vector_entrada = Vector2.ZERO
	vector_entrada.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	vector_entrada.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	vector_entrada = vector_entrada.normalized()
	
	if abs(vector_entrada.cross(Vector2.ONE)) == 1:
		arbolAnimacion.set("parameters/quieto/blend_position", vector_entrada)
		arbolAnimacion.set("parameters/correr/blend_position", vector_entrada)
		arbolAnimacion.set("parameters/atacar_SA/blend_position", vector_entrada)
		arbolAnimacion.set("parameters/atacar_CA/blend_position", vector_entrada)
		
		estadoAnimacion.travel("correr")
		
		velocidad = vector_entrada * 64
	else:
		estadoAnimacion.travel("quieto")
		velocidad = Vector2.ZERO * delta
	
	velocidad = move_and_slide(velocidad)
	
	if Input.is_action_just_pressed("atacar"):
		estado = ATACAR
	
func estado_atacar(delta, banArmado):
	if banArmado == false:
		estadoAnimacion.travel("atacar_SA")
	else:
		estadoAnimacion.travel("atacar_CA")
	
func terminar_ataque():
	if get_colision() != null:
		colisionando = true
		
	if banArmado == true and colisionando == true:
		saludRama = saludRama - 25
		if saludRama == 0:
			banArmado = false
	print("Salud rama: " + str(saludRama))
	colisionando = false
	estado = MOVER



func get_colision():
	for i in get_slide_count():
		var collision = get_slide_collision(i).collider
		
		return collision

func armarJugador():
	saludRama = 100
	banArmado = true
