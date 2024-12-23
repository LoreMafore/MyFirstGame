extends State
class_name SoldierSees

@export var soldier : CharacterBody2D
@export var moveSpeed: float = 1.0
@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var right = $"../../RayCast/Right"
@onready var left = $"../../RayCast/Left"


var player: CharacterBody2D
var following : bool = false
var isNegative : bool = false
var enemyPositionX : float = 0.00
var enemyPositionY : float = 0.00
#var moveDirection : int = 1

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	print("Soldier sees")
	

func physicsUpdate(delta : float):
	
	soldier.velocity.x = soldier.soldierMovement
	
	var directionX = player.global_position.x - soldier.global_position.x
	var directionY = player.global_position.y - soldier.position.y
	
	if  not right.is_colliding() or soldier.global_position.x > player.global_position.x and soldier.global_position.y < player.global_position.y+50:
		animated_sprite_2d.flip_h = true
		print("A")
		print("Abs Direction X: ", abs(directionX))
			
	elif not left.is_colliding() or soldier.global_position.x < player.global_position.x and soldier.global_position.y < player.global_position.y + 50:
		animated_sprite_2d.flip_h = false
		print("B")
		print("Abs Direction X: ", abs(directionX))
		print("Playery X: ",player.global_position.y)
		print("Soldier X: ",soldier.global_position.y)
		
	if soldier:
		print("Abs Direction X: ", abs(directionX))
		
		#attacks
		if abs(directionX) > 0 and abs(directionX) < 15 and abs(directionY) > 1.5 and abs(directionY) < 50:
			soldier.velocity.x *= 0
			Transitioned.emit(self, "soldiervattack")
			
		if abs(directionX) > 0 and abs(directionX) < 15 and abs(directionY) < 1.5:
			soldier.velocity.x *= 0
			Transitioned.emit(self, "soldierhattack")
			
		if abs(directionX) > 250: 
			Transitioned.emit(self, "soldierwalking")
