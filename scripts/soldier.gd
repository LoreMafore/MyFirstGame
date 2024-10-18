extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var isFacingRight : bool = false
@export var soldier : CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var lengthOfPath : float = 25.0

var soldierInitPosition : float = 0.00

func _ready():
	if isFacingRight == true:
		animated_sprite_2d.flip_h = true
		
	soldierInitPosition = soldier.global_position.x 


func _physics_process(delta):
	move_and_slide()
	
	if not is_on_floor():
		velocity.y = gravity * delta * 100
		
	if velocity.x != 0:
		animated_sprite_2d.play("Walking")
