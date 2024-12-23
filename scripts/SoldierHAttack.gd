extends State
class_name SoldierHAttack

@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var soldier1: CharacterBody2D = $"../.."


var player : CharacterBody2D
var soldier : CharacterBody2D


func Enter():
	soldier1._horizantal_attack()
		
