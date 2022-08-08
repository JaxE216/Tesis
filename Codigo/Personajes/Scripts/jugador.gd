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
var saludJugador = 100
var banArmado = false
var saludRama

var llaveRoja = false
var llavePlata = false
var llaveDorada = false

onready var animacion = $AnimationPlayer
onready var arbolAnimacion = $AnimationTree
onready var estadoAnimacion = arbolAnimacion.get("parameters/playback")
onready var hitboxGolpeCA = $direccionGolpe/areaGolpeoCA
onready var hitboxGolpeSA = $direccionGolpe/areaGolpeoSA

func _ready():
	arbolAnimacion.active = true
	hitboxGolpeCA.vector_direccionGolpe = Vector2.LEFT
	hitboxGolpeSA.vector_direccionGolpe = Vector2.LEFT

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
		hitboxGolpeCA.vector_direccionGolpe = vector_entrada
		hitboxGolpeSA.vector_direccionGolpe = vector_entrada
		
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
	print(get_colision())
	if get_colision() != null:
		colisionando = true
		
	if banArmado == true and colisionando == true:
		saludRama = saludRama - 25
		if saludRama == 0:
			banArmado = false
	print("Salud rama: " + str(saludRama))
	colisionando = false
	estado = MOVER
### No se detecta la colisión entre la rama y el enemigo por lo que no se puede 
### restar daño a la rama cuando se  golpea a un enemigo


func get_colision():
	for i in get_slide_count():
		var collision = get_slide_collision(i).collider
		
		return collision

func armarJugador():
	saludRama = 100
	banArmado = true

func recogerLlave(tipoLlave):
	print(tipoLlave)
	
	match tipoLlave:
		'LlaveRoja', 'LlaveCaidaR':
			llaveRoja = true
		'LlavePlata', 'LlaveCaidaP':
			llavePlata = true
		'LlaveDorada', 'LlaveCaidaD':
			llaveDorada = true


func _on_hurtBox_area_entered(area):
	print('Salud jugador: ')
	print(saludJugador)
	if area.name == 'HitBoxEnemigo':
		saludJugador = saludJugador - 10
	print(saludJugador)
	if saludJugador <= 0:
		print('Has morido')


func _on_areaGolpeoCA_area_entered(area):
	print(area.name)
	if area.name == 'HitBoxEnemigo':
		saludRama = saludRama - 25
		if saludRama == 0:
			banArmado = false
