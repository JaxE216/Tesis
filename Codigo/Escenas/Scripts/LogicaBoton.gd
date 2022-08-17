extends StaticBody2D


func _ready():
	pass # Replace with function body.


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
