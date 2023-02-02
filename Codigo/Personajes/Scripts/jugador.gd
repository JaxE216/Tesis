extends KinematicBody2D

class_name Jugador

signal diamanteRecogido(count)
signal llaveRojaRecogida()
signal llavePlateadaRecogida()
signal llaveDoradaRecogida()
signal golpeadoPorEnemigo(count)
signal mostrarSaludRama(salud)

const VEL_MAX = 200

enum {
	MOVER,
	ATACAR
}

# Variables de control
var velocidad = Vector2.ZERO
var multiplicadorVelocidad = 1
var estado = MOVER
var colisionando = false

# Variables de estado
var saludJugador = Checkpoints.cont_vidas
var banArmado = Checkpoints.ban_armado
var saludRama = Checkpoints.rama

var llaveRoja = false
var llavePlata = false
var llaveDorada = false

onready var nivel = get_node(".").get_parent().name
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
	
	print('diamantes: ' + str(Checkpoints.cont_diamantes))
	
	if Checkpoints.cont_diamantes >= 6:
		multiplicadorVelocidad = 1.3
	if Checkpoints.cont_diamantes >= 15:
		banArmado = true
	
	if Checkpoints.reaparicion and nivel != 'Menu':
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
		
		velocidad = vector_entrada * 64 * multiplicadorVelocidad
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
	if banArmado == true and colisionando == true and Checkpoints.cont_diamantes < 15:
		saludRama = saludRama - 25
		Checkpoints.rama = saludRama
		SaveScript.game_data.rama = Checkpoints.rama
		
		if saludRama == 0:
			banArmado = false
			Checkpoints.ban_armado = banArmado
			SaveScript.game_data.ban_armado = Checkpoints.ban_armado
		
		SaveScript.save_data()
		emit_signal("mostrarSaludRama", Checkpoints.rama)
	colisionando = false
	estado = MOVER


func get_colision():
	for i in get_slide_count():
		var collision = get_slide_collision(i).collider
		
		return collision

func armarJugador():
	banArmado = true
	Checkpoints.ban_armado = banArmado
	SaveScript.game_data.ban_armado = banArmado
	
	saludRama = 100
	Checkpoints.rama = saludRama
	SaveScript.game_data.rama = Checkpoints.rama
	#SaveScript.save_data()
	
	emit_signal("mostrarSaludRama", Checkpoints.rama)

func recogerLlave(tipoLlave):
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
	match(area.name):
		'AreaChoqueJugador':
			Checkpoints.cont_vidas = Checkpoints.cont_vidas - 1
			SaveScript.game_data.cont_vidas = Checkpoints.cont_vidas
			saludJugador = Checkpoints.cont_vidas
			emit_signal("golpeadoPorEnemigo", Checkpoints.cont_vidas)
			
			SaveScript.save_data()
			
			if Checkpoints.cont_vidas <= 0:
				Checkpoints.cont_vidas = 6
				saludJugador = Checkpoints.cont_vidas
				
				if Checkpoints.cont_diamantes < 15:
					Checkpoints.ban_armado = false
					banArmado = Checkpoints.ban_armado
					
					Checkpoints.rama = 0
					saludRama = Checkpoints.rama
					
					SaveScript.game_data.ban_armado = Checkpoints.ban_armado
					SaveScript.game_data.rama = Checkpoints.rama
				
				SaveScript.game_data.cont_vidas = Checkpoints.cont_vidas
				emit_signal("mostrarSaludRama", Checkpoints.rama)
				emit_signal("golpeadoPorEnemigo", Checkpoints.cont_vidas)
				
				if Checkpoints.reaparicion:
					global_position = Checkpoints.reaparicion
				else:
					global_position = get_parent().get_node("PosInicial").global_position
					Checkpoints.reaparicion = global_position
					SaveScript.game_data.reaparicion = Checkpoints.reaparicion
					
				SaveScript.save_data()
		'HitBoxDiamante':
			Checkpoints.cont_diamantes = Checkpoints.cont_diamantes + 1
			
			match Checkpoints.cont_diamantes:
				6: 
					multiplicadorVelocidad = 1.3
				15:
					banArmado = true
					Checkpoints.ban_armado = banArmado
					SaveScript.game_data.ban_armado = banArmado
					
					saludRama = 100
					Checkpoints.rama = saludRama
					SaveScript.game_data.rama = Checkpoints.rama
					SaveScript.save_data()
					
					emit_signal("mostrarSaludRama", Checkpoints.rama)
					
			emit_signal("diamanteRecogido", Checkpoints.cont_diamantes)
			
			

### Golpeo de enemigos con rama
func _on_areaGolpeoCA_area_entered(area):
	colisionando = true

### Golpeo de enemigos y escenario sin rama
func _on_areaGolpeoSA_body_entered(body):
	colisionando = true

### Golpeo de escenario con rama
func _on_areaGolpeoCA_body_entered(body):
	colisionando = true
