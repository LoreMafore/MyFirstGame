extends State
class_name SoldierVAttack

var player : CharacterBody2D
var soldier : CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var soldier1: CharacterBody2D = $"../.."

func Enter():
	print("Solder V Attack")
	soldier1._vertical_attack()
