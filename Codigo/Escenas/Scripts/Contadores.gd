extends Control

func _ready():
	$Cont_Diamantes/Label.text = str(SaveScript.game_data.cont_diamantes)
	$Cont_Llaves/LlaveD.visible = Checkpoints.ban_llaveD
	$Cont_Llaves/LlaveR.visible = Checkpoints.ban_llaveR
	$Cont_Llaves/LlaveP.visible = Checkpoints.ban_llaveP

func _on_jugador_diamanteRecogido(count):
	$Cont_Diamantes/Label.text = str(count)

func _on_jugador_llaveDoradaRecogida():
	$Cont_Llaves/LlaveD.visible = true


func _on_jugador_llavePlateadaRecogida():
	$Cont_Llaves/LlaveP.visible = true


func _on_jugador_llaveRojaRecogida():
	$Cont_Llaves/LlaveR.visible = true
