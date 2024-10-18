extends State
class_name SoldierIdle

@onready var animated_sprite_2d = $"../../AnimatedSprite2D"

@export var soldier : CharacterBody2D
@export var moveSpeed: float = 45.0 

var player: CharacterBody2D
var movementDirection: int = 1

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Update(delta: float):
	if animated_sprite_2d.flip_h == false:
		movementDirection = 1
	
	else:
		movementDirection = -1

func physicsUpdate(delta: float):
	
	if soldier:
		soldier.velocity.x = moveSpeed * movementDirection
		var directionX = player.global_position.x - soldier.global_position.x
		
		if abs(directionX) >= 30 and abs(directionX) <= 50:
			Transitioned.emit(self, "soldiersees")
			
		
		
		if soldier.global_position.x >=  soldier.soldierInitPosition + soldier.lengthOfPath:
			animated_sprite_2d.flip_h = true
			#moveSpeed = 0
			
		if soldier.global_position.x <= soldier.soldierInitPosition - soldier.lengthOfPath:
			animated_sprite_2d.flip_h = false
			#moveSpeed = 0
			
		
			
		
			
			#I just flip it becaus e you =can tell what direction it is facing and change the movement direction
		
