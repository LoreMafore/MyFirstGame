extends Area2D


func _ready():
	pass # Replace with function body.

func _on_body_entered(body):
	#LastPosition.lastPosition = global_position
	
	Global.placeHolderPositionX = body.position.x
	Global.placeHolderPositionY = body.position.y
	
