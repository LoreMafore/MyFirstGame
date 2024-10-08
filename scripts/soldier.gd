extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var isFacingRight : bool = false

@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	if isFacingRight == true:
		animated_sprite_2d.flip_h = true
	


func _physics_process(delta):
	if not is_on_floor():
		velocity.y = gravity * delta

	move_and_slide()
