extends Control

@onready var setting_options = $Background/SettingOptions
@onready var audio_visual_options = $Background/Audio_VisualOptions

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass


func _on_audio_visual_pressed():
	_exit_settings(setting_options,audio_visual_options)


func _on_quit_pressed():
	get_tree().quit()
	
func _exit_settings(exit_from,exit_to):
	exit_from.visible = false
	exit_to.visible = true


func _on_fps_item_selected(index):
	match index:
		0: Engine.max_fps = 30
		1: Engine.max_fps = 60


func _on_gameplay_menu_item_selected(index):
	match index:
		0: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
