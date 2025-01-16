extends Control


func _ready():
	pass # Replace with function body.


func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://scences/level_1.tscn")


func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://scences/level_2.tscn")


func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://scences/level_3.tscn")
