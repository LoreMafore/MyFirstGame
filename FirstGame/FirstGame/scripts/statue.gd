extends Area2D

var closeToStatue: bool = false

@onready var double_jump: Label = %"Double Jump"
@onready var player = %Player

func _process(delta):
	if Input.is_action_just_pressed("Interact") and closeToStatue == true:
		print("I am gay")
		player.doubleJumpOn()



func _on_body_entered(body):
	closeToStatue = true
	double_jump.visible = true
	


func _on_body_exited(body):
	closeToStatue = false
	double_jump.visible = false
