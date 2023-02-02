extends Control

func _ready():
	$Cont_Diamantes/Label.text = str(SaveScript.game_data.cont_diamantes)
	$Cont_Llaves/LlaveD.visible = Checkpoints.ban_llaveD
	$Cont_Llaves/LlaveR.visible = Checkpoints.ban_llaveR
	$Cont_Llaves/LlaveP.visible = Checkpoints.ban_llaveP
	
	_on_jugador_mostrarSaludRama(Checkpoints.rama)
	
	match(Checkpoints.cont_vidas):
		6:
			$Cont_VidaRestante/Vida_5.visible = true
			$Cont_VidaRestante/Vida_4.visible = true
			$Cont_VidaRestante/Vida_3.visible = true
			$Cont_VidaRestante/Vida_2.visible = true
			$Cont_VidaRestante/Vida_1.visible = true
			$Cont_VidaRestante/Vida_0.visible = true
		5: 
			$Cont_VidaRestante/Vida_5.visible = false
		4:
			$Cont_VidaRestante/Vida_5.visible = false
			$Cont_VidaRestante/Vida_4.visible = false
		3:
			$Cont_VidaRestante/Vida_5.visible = false
			$Cont_VidaRestante/Vida_4.visible = false
			$Cont_VidaRestante/Vida_3.visible = false
		2:
			$Cont_VidaRestante/Vida_5.visible = false
			$Cont_VidaRestante/Vida_4.visible = false
			$Cont_VidaRestante/Vida_3.visible = false
			$Cont_VidaRestante/Vida_2.visible = false
		1:
			$Cont_VidaRestante/Vida_5.visible = false
			$Cont_VidaRestante/Vida_4.visible = false
			$Cont_VidaRestante/Vida_3.visible = false
			$Cont_VidaRestante/Vida_2.visible = false
			$Cont_VidaRestante/Vida_1.visible = false

func _on_jugador_diamanteRecogido(count):
	$Cont_Diamantes/Label.text = str(count)

func _on_jugador_llaveDoradaRecogida():
	$Cont_Llaves/LlaveD.visible = true


func _on_jugador_llavePlateadaRecogida():
	$Cont_Llaves/LlaveP.visible = true


func _on_jugador_llaveRojaRecogida():
	$Cont_Llaves/LlaveR.visible = true


func _on_jugador_golpeadoPorEnemigo(count):
	match(count):
		6:
			$Cont_VidaRestante/Vida_5.visible = true
			$Cont_VidaRestante/Vida_4.visible = true
			$Cont_VidaRestante/Vida_3.visible = true
			$Cont_VidaRestante/Vida_2.visible = true
			$Cont_VidaRestante/Vida_1.visible = true
			$Cont_VidaRestante/Vida_0.visible = true
		5: 
			$Cont_VidaRestante/Vida_5.visible = false
		4:
			$Cont_VidaRestante/Vida_4.visible = false
		3:
			$Cont_VidaRestante/Vida_3.visible = false
		2:
			$Cont_VidaRestante/Vida_2.visible = false
		1:
			$Cont_VidaRestante/Vida_1.visible = false
		0:
			$Cont_VidaRestante/Vida_0.visible = false


func _on_jugador_mostrarSaludRama(salud):
	match(salud):
		100:
			$Cont_Rama/RamaFull.visible = true
			$Cont_Rama/Rama_3.visible = false
			$Cont_Rama/Rama_2.visible = false
			$Cont_Rama/Rama_1.visible = false
		75:
			$Cont_Rama/RamaFull.visible = false
			$Cont_Rama/Rama_3.visible = true
			$Cont_Rama/Rama_2.visible = false
			$Cont_Rama/Rama_1.visible = false
		50:
			$Cont_Rama/RamaFull.visible = false
			$Cont_Rama/Rama_3.visible = false
			$Cont_Rama/Rama_2.visible = true
			$Cont_Rama/Rama_1.visible = false
		25:
			$Cont_Rama/RamaFull.visible = false
			$Cont_Rama/Rama_3.visible = false
			$Cont_Rama/Rama_2.visible = false
			$Cont_Rama/Rama_1.visible = true
		0:
			$Cont_Rama/RamaFull.visible = false
			$Cont_Rama/Rama_3.visible = false
			$Cont_Rama/Rama_2.visible = false
			$Cont_Rama/Rama_1.visible = false
