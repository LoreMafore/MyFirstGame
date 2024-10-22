extends State
class_name SoldierHAttack

@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var attack_1a = $"../../AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1A"
@onready var attack_1b = $"../../AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1B"

var player : CharacterBody2D
var soldier : CharacterBody2D


func Enter():
	player = get_tree().get_first_node_in_group("Player")
	animated_sprite_2d.play("HorizantalAttack")
	
func physicsUpdate(delta : float):
	Transitioned.emit(self, "soldiersees")
	
