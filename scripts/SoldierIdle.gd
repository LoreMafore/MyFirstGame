extends State
class_name SoldierIdle

@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var left = $"../../Left"
@onready var right = $"../../Right"


@export var soldier : CharacterBody2D

var player: CharacterBody2D
var movementDirection: int = 1

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	print("Soldier Idle")

func physicsUpdate(delta: float):
	
	if soldier:
		
		soldier.velocity.x = soldier.soldierMovement
		
		#distance between player and enemy
		var directionX = player.global_position.x - soldier.global_position.x
		var directionY = player.global_position.y - soldier.position.y
		
		if abs(directionX) >= 21 and abs(directionX) <= 50 and abs(directionY) < 50:
			Transitioned.emit(self, "soldiersees")
			
		
		if soldier.global_position.x >=  soldier.soldierInitPosition + soldier.lengthOfPath or not right.is_colliding():
			animated_sprite_2d.flip_h = true
			
		if soldier.global_position.x <= soldier.soldierInitPosition - soldier.lengthOfPath or not left.is_colliding():
			animated_sprite_2d.flip_h = false
			
		
