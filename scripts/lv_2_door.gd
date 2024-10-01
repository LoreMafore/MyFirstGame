extends Area2D

@export var closeToDoor : bool = false

func _on_body_entered(body):
	closeToDoor = true


func _on_body_exited(body):
	closeToDoor = false
	
#func _process(delta):
	#if Input.is_action_just_pressed("Interact") and closeToDoor == true:
		#get_tree().change_scene_to_file("res://scences/level_1_back.tscn")
