extends StaticBody2D

func _ready():
	print(get_node(".").name)


func _on_HitBox_body_entered(body):
	print(body.name)
