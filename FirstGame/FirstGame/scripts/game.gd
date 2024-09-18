extends Node2D

func _enter_tree():
	if LastPosition.lastPosition:
		$Player.global_position = LastPosition.lastPosition
