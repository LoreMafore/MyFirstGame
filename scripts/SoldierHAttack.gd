extends State
class_name SoldierHAttack

@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var attack_1a = $"../../AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1A"
@onready var attack_1b = $"../../AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1B"

var soldier : CharacterBody2D


func Enter():
	animated_sprite_2d.play("HorizantalAttack")
	#if frame => 5:
	attack_1a.disabled = false
	attack_1b.disabled = false
	
