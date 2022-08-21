extends KinematicBody2D

class_name Jugador

signal diamanteRecogido(count)
signal llaveRojaRecogida()
signal llavePlateadaRecogida()
signal llaveDoradaRecogida()

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
	
	llaveRoja = Checkpoints.ban_llaveR
	llavePlata = Checkpoints.ban_llaveP
	llaveDorada = Checkpoints.ban_llaveD
	
	if Checkpoints.reaparicion:
		global_position = Checkpoints.reaparicion
	else:
		global_position = get_parent().get_node("PosInicial").global_position

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
	print("Colisionando: " + str(colisionando))
	if banArmado == true and colisionando == true:
		print("Salud rama: " + str(saludRama))
		saludRama = saludRama - 25
		if saludRama == 0:
			banArmado = false
	
	colisionando = false
	estado = MOVER


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
			Checkpoints.ban_llaveR = true
			SaveScript.game_data.reaparicion = Checkpoints.reaparicion
			SaveScript.game_data.ban_llaveR = Checkpoints.ban_llaveR
			SaveScript.save_data()
			
			emit_signal("llaveRojaRecogida")
		'LlavePlata', 'LlaveCaidaP':
			llavePlata = true
			Checkpoints.ban_llaveP = true
			SaveScript.game_data.reaparicion = Checkpoints.reaparicion
			SaveScript.game_data.ban_llaveP = Checkpoints.ban_llaveP
			SaveScript.save_data()
			
			emit_signal("llavePlateadaRecogida")
		'LlaveDorada', 'LlaveCaidaD':
			llaveDorada = true
			Checkpoints.ban_llaveD = true
			SaveScript.game_data.reaparicion = Checkpoints.reaparicion
			SaveScript.game_data.ban_llaveD = Checkpoints.ban_llaveD
			SaveScript.save_data()
			
			emit_signal("llaveDoradaRecogida")


func _on_hurtBox_area_entered(area):
	print('Salud jugador: ' + str(saludJugador))
	match(area.name):
		'HitBoxEnemigo':
			saludJugador = saludJugador - 10
		'HitBoxDiamante':
			Checkpoints.cont_diamantes = Checkpoints.cont_diamantes + 1
			emit_signal("diamanteRecogido", Checkpoints.cont_diamantes)
	print(saludJugador)
	if saludJugador <= 0:
		if Checkpoints.reaparicion:
			global_position = Checkpoints.reaparicion
			saludJugador = 100
		else:
			global_position = get_parent().get_node("PosInicial").global_position


func _on_areaGolpeoCA_area_entered(area):
	print('Golpeó con arma: ' + str(area.name))
	colisionando = true
	#if area.name == 'HitBoxEnemigo':
		#saludRama = saludRama - 25
		#if saludRama == 0:
			#terminar_ataque()
			#banArmado = false


func _on_areaGolpeoSA_body_entered(body):
	print('Golpeó sin arma: ' + str(body.name))
	colisionando = true


func _on_areaGolpeoCA_body_entered(body):
	print('Golpeó con arma: ' + str(body.name))
	colisionando = true
