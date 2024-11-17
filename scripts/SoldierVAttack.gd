extends State
class_name SoldierVAttack

var player : CharacterBody2D
var soldier : CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var soldier1: CharacterBody2D = $"../.."
@onready var v_attack = $VAttack

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	if soldier1.canAttack == true: 
		animated_sprite_2d.play("VerticalAttack")
		v_attack.start()
		
	else:
		Transitioned.emit(self, "soldiersees")


func _on_v_attack_timeout():
	Transitioned.emit(self, "soldiersees")
