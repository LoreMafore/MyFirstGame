extends Area2D

var closeToStatue: bool = false


@onready var player = %Player

func _process(delta):
	if Input.is_action_just_pressed("Interact") and closeToStatue == true:
		print("I am gay")
		player.doubleJumpOn()



func _on_body_entered(body):
	closeToStatue = true


func _on_body_exited(body):
	closeToStatue = false
