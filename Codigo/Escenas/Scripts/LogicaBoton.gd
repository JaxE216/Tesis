extends StaticBody2D

onready var botonName = get_node(".").name


func _on_HitBox_body_entered(body):
	if body.name == 'jugador':
		get_node("BotonSpriteSP").visible = false
		get_node("BotonSpriteP").visible = true


func _on_HitBox_body_exited(body):
	if body.name == 'jugador':
		get_node("BotonSpriteSP").visible = true
		get_node("BotonSpriteP").visible = false


func _on_HitBox_area_entered(area):
	match(botonName):
		'Btn_NuevoJuego':
			get_tree().change_scene("res://Niveles/Nivel_1.tscn")
		'Btn_Salir':
			get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)

