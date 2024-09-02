extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@export var mushroomYJump : int
@export var mushroomXJump: float = 200.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	move_and_slide()


func _on_tip_body_entered(body):
	if Input.is_action_pressed("jump"):
		body.velocity.y = -mushroomYJump
		body.velocity.x += mushroomXJump
		#body.MushroomJump(mushroomJump)
		animated_sprite_2d.play("Activate")
