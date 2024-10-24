extends State
class_name SoldierVAttack

var player : CharacterBody2D
var soldier : CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	animated_sprite_2d.play("VerticalAttack")
