extends Area2D

@onready var press_e = %"Press E"

@export var closeToDoor : bool = false


func _on_body_entered(body):
	closeToDoor = true
	print("I am true")

func _on_body_exited(body):
	closeToDoor = false


func _process(delta):
	
	if closeToDoor == false:
		press_e.visible = false
		
	else:
		press_e.visible = true
	
	if Input.is_action_pressed("Interact") or Input.is_action_just_pressed("Interact") and closeToDoor == true:
		get_tree().change_scene_to_file("res://scences/level_2.tscn")

