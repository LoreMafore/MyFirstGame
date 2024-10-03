extends Area2D

var closeToStatue: bool = false

@onready var double_jump: Label = %"Double Jump"
@onready var player = %Player
@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	animated_sprite_2d.play("default")

func _process(delta):
	if Input.is_action_just_pressed("Interact") and closeToStatue == true:
		animated_sprite_2d.play("Falling_apart")
		player.doubleJumpOn()



func _on_body_entered(body):
	closeToStatue = true
	double_jump.visible = true
	


func _on_body_exited(body):
	closeToStatue = false
	double_jump.visible = false
