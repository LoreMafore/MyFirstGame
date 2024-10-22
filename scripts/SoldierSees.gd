extends State
class_name SoldierSees

@export var soldier : CharacterBody2D
@export var moveSpeed: float = 1.0
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
var player: CharacterBody2D
var following : bool = false
var isNegative : bool = false
var enemyPositionX : int = 0.00
var enemyPositionY : int = 0.00
var moveDirection : int = 1

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func physicsUpdate(delta : float):
	
	var directionX = player.global_position.x - soldier.global_position.x
	var directionY = player.global_position.y - soldier.position.y
	
	if soldier.global_position.x > player.global_position.x:
		animated_sprite_2d.flip_h = true
		
	if soldier.global_position.x < player.global_position.x: 
		animated_sprite_2d.flip_h = false
		
	if soldier:
		
		if abs(directionX) > 0 and abs(directionX) < 15:
			soldier.velocity.x *= 0
			Transitioned.emit(self, "soldierhattack")
		
		if abs(directionX) > 50:
			print(following)
			soldier.velocity.x = sign(directionX) * moveSpeed * moveDirection
			
		if abs(directionX) > 100: 
			soldier.velocity.x = 0
			Transitioned.emit(self, "soldierwalking")
