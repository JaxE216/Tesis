extends StaticBody2D

onready var botonName = get_node(".").name
var nivel
var confirmarBorrado = false

func _on_HitBox_body_entered(body):
	
	if body.name == 'jugador':
		get_node("BotonSpriteSP").visible = false
		get_node("BotonSpriteP").visible = true
		


func _on_HitBox_body_exited(body):
	if body.name == 'jugador':
		get_node("BotonSpriteSP").visible = true
		get_node("BotonSpriteP").visible = false


func _on_HitBox_area_entered(area):
	print(area.name)
	match(botonName):
		'Btn_NuevoJuego':
			if SaveScript.game_data.ban_guardado:
				get_node(".").get_parent().get_node("GUI/ConfirmarBorrado").visible = true
				get_node(".").get_parent().get_node("GUI/Contadores").visible = false
				get_node(".").get_parent().get_node("GUI/Joystick").visible = false
				get_tree().paused = true
			else:
				Checkpoints.vaciarDatos()
				Checkpoints.cont_diamantes = 0
				Checkpoints.cont_vidas = 6
				Checkpoints.ban_armado = false
				Checkpoints.rama = 0
				SaveScript.delete_data()
				get_tree().change_scene("res://Niveles/Nivel_1.tscn")
			
		'Btn_Continuar':
			nivel = "res://Niveles/" + SaveScript.game_data.nivel
			get_tree().change_scene(nivel)
		'Btn_Salir':
			get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)



func _on_Btn_Si_pressed():
	get_tree().paused = false
	Checkpoints.vaciarDatos()
	Checkpoints.cont_diamantes = 0
	Checkpoints.cont_vidas = 6
	Checkpoints.ban_armado = false
	Checkpoints.rama = 0
	SaveScript.delete_data()
	get_tree().change_scene("res://Niveles/Nivel_1.tscn")


func _on_Btn_No_pressed():
	get_node(".").get_parent().get_node("GUI/ConfirmarBorrado").visible = false
	get_node(".").get_parent().get_node("GUI/Contadores").visible = true
	get_node(".").get_parent().get_node("GUI/Joystick").visible = true
	get_tree().paused = false
	
