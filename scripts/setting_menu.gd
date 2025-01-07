extends Control

@onready var setting_options = $Background/SettingOptions
@onready var audio_visual_options = $Background/Audio_VisualOptions

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass


func _on_audio_visual_pressed():
	_exit_settings(setting_options,audio_visual_options)

func _on_gameplay_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().quit()
	
func _exit_settings(exit_from,exit_to):
	exit_from.visible = false
	exit_to.visible = true
