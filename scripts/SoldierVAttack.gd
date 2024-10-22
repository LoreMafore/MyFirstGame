extends State
class_name SoldierVAttack

var player : CharacterBody2D
var soldier : CharacterBody2D


func Enter():
	player = get_tree().get_first_node_in_group("Player")
