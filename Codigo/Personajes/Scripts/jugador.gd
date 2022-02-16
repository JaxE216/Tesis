extends KinematicBody2D

class_name Jugador

const VEL_MAX = 200

enum {
	MOVER,
	ATACAR
}

# Variables de control
var velocidad = Vector2.ZERO
var estado = MOVER
var colisionando = false

# Variables de estado
var banArmado = false
var saludRama

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

func recogerLlave():
	print('llave recogida')


# Por si la cago está respaldado
"""extends KinematicBody2D

const VEL_MAX = 200

enum {
	MOVER,
	ATACAR
}

var velocidad = Vector2.ZERO
var estado = MOVER
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
			for i in get_slide_count():
				var collision = get_slide_collision(i)
				
				if collision.collider is Diamante:
					if collision.collider.name == "DiamanteCaido":
						if collision.collider.is_visible() == true:
							get_node(".").get_parent().get_node(ultimo_arbolDiamante_tocado).queue_free()
							#get_node(".").get_parent().get_node(ultimo_arbolDiamante_tocado + "/DiamanteCaido/Diamante_sprite").queue_free()
							#get_node(".").get_parent().get_node(ultimo_arbolDiamante_tocado + "/DiamanteCaido/CollisionShape2D").queue_free()
					else:
						print("Chocó al mover con: " + collision.collider.name)
						collision.collider.queue_free()
				if collision.collider is ArbolDiamante:
					print("Poner imagen para poder golpear el árbol")
				if collision.collider is Rama:
					if collision.collider.is_visible() == true:
						get_node(".").get_parent().get_node(ultimo_arbolRama_tocado + "/Rama").hide()
						get_node(".").get_parent().get_node(ultimo_arbolRama_tocado + "/Rama/CollisionShape2D").disabled = true
						get_node(".").get_parent().get_node(ultimo_arbolRama_tocado + "/arbolRamaSprite").show()
						get_node(".").get_parent().get_node(ultimo_arbolRama_tocado + "/arbolSprite").hide()
		ATACAR:
			estado_atacar(delta)
			for i in get_slide_count():
				var collision = get_slide_collision(i)
				var nodo = collision.collider.name
				
				if collision.collider is ArbolDiamante:
					get_node(".").get_parent().get_node(nodo + "/DiamanteCaido").show()
					get_node(".").get_parent().get_node(nodo + "/DiamanteCaido/CollisionShape2D").disabled = false
					get_node(".").get_parent().get_node(nodo + "/ArbolDiamante").hide()
					get_node(".").get_parent().get_node(nodo + "/ArbolSinDiamante").show()
					ultimo_arbolDiamante_tocado = nodo
				if collision.collider is ArbolRama:
					get_node(".").get_parent().get_node(nodo + "/Rama").show()
					get_node(".").get_parent().get_node(nodo + "/Rama/CollisionShape2D").disabled = false
					get_node(".").get_parent().get_node(nodo + "/arbolRamaSprite").hide()
					get_node(".").get_parent().get_node(nodo + "/arbolSprite").show()
					ultimo_arbolRama_tocado = nodo

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
	
func estado_atacar(delta):
	estadoAnimacion.travel("atacar_SA")
	
func terminar_ataque():
	estado = MOVER"""
