extends State
class_name SoldierHAttack

@onready var animated_sprite_2d = $"../../AnimatedSprite2D"

var soldier : CharacterBody2D


func Enter():
	animated_sprite_2d.play("HorizantalAttack")
