extends State
class_name SoldierSees

@export var soldier : CharacterBody2D
@export var moveSpeed: float = 1.0
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var left = $"../../Left"
@onready var right = $"../../Right"

var player: CharacterBody2D
var following : bool = false
var isNegative : bool = false
var enemyPositionX : int = 0.00
var enemyPositionY : int = 0.00
var moveDirection : int = 1

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	print("Soldier sees")

func physicsUpdate(delta : float):
	
	soldier.velocity.x = soldier.soldierMovement
	
	var directionX = player.global_position.x - soldier.global_position.x
	var directionY = player.global_position.y - soldier.position.y
	
	#abs(directionX) <= 10 and 
	if abs(directionY) > 50:
		return
	
	elif soldier.global_position.x > player.global_position.x or not right.is_colliding():
		animated_sprite_2d.flip_h = true
		print("A")
		
	elif soldier.global_position.x < player.global_position.x or not left.is_colliding(): 
		animated_sprite_2d.flip_h = false
		soldier.velocity.x *= 0
		print("B")
		
	if soldier:
		
		#attacks
		if abs(directionX) > 0 and abs(directionX) < 15 and abs(directionY) > 1.5 and abs(directionY) < 50:
			soldier.velocity.x *= 0
			Transitioned.emit(self, "soldiervattack")
			
		if abs(directionX) > 0 and abs(directionX) < 15 and abs(directionY) < 1.5:
			soldier.velocity.x *= 0
			Transitioned.emit(self, "soldierhattack")
			
		#following 
		#if abs(directionX) > 20 and abs(directionY) > 0 and abs(directionY) < 50:
			#soldier.velocity.x = sign(directionX) * moveSpeed * moveDirection
			
		if abs(directionX) > 21: 
			Transitioned.emit(self, "soldieridle")
