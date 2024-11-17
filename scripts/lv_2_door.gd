extends Area2D

@export var closeToDoor : bool = false

func _on_body_entered(body):
	closeToDoor = true


func _on_body_exited(body):
	closeToDoor = false
	
