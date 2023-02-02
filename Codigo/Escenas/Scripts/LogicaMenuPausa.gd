extends Control

var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("pausar"):
		print(get_parent().name)
		get_parent().get_node("Joystick").visible = false
		get_parent().get_node("Pausar").visible = false
		self.is_paused = !is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused

func _on_Btn_Continuar_pressed():
	self.is_paused = false
	
	get_parent().get_node("Joystick").visible = true
	get_parent().get_node("Pausar").visible = true

func _on_Btn_Salir_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
