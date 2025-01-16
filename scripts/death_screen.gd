extends Control

@onready var yes: Button = $Respawn/Yes
@onready var no: Button = $Respawn/No
@onready var death_screen: Control = $"."
var player : CharacterBody2D

func _ready() -> void:
	death_screen.visible = false
	player = get_tree().get_first_node_in_group("Player")

func _on_yes_pressed() -> void:
	get_tree().reload_current_scene()

func _on_no_pressed() -> void:
	get_tree().change_scene_to_file("res://scences/Menu.tscn")
