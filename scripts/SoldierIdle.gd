extends State
class_name SoldierIdle

@onready var animated_sprite_2d = $"../../AnimatedSprite2D"

@export var soldier : CharacterBody2D
@export var moveSpeed: float = 45.0 
var movementDirection: int = 1

func Update(delta: float):
	if animated_sprite_2d.flip_h == false:
		movementDirection = 1
	
	else:
		movementDirection = -1

func physicsUpdate(delta: float):
	if soldier:
		soldier.velocity.x = moveSpeed * movementDirection
		print(soldier.velocity.x)
