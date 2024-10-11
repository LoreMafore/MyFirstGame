extends State
class_name SoldierSees

@export var soldier : CharacterBody2D
@export var moveSpeed: float = 45.0
var player: CharacterBody2D
var following = false

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	
func physicsUpdate(delta : float):
	
	var directionX = player.global_position.x - soldier.global_position.x
	var directionY = player.global_position.y - soldier.global_position.y
	
	if directionX > 25:
		var following = true
		
	if following == true:
		soldier.velocity = directionX.normalizwed() * moveSpeed
