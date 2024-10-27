extends State
class_name SoldierVAttack

var player : CharacterBody2D
var soldier : CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var soldier1: CharacterBody2D = $"../.."

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	if soldier1.canAttack == true: 
		animated_sprite_2d.play("VerticalAttack")
		
	else:
		Transitioned.emit(self, "soldiersees")
	
	
func physicsUpdate(delta : float):
	Transitioned.emit(self, "soldiersees")
