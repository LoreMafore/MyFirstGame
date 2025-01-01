extends Control

@onready var yes: Button = $Respawn/Yes
@onready var no: Button = $Respawn/No
@onready var death_screen: Control = $"."

func _ready() -> void:
	death_screen.visible = false
	



func _on_yes_pressed() -> void:
	get_tree().reload_current_scene()

func _on_no_pressed() -> void:
	get_tree().quit()
