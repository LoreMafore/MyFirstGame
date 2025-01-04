extends Control

@onready var background: Panel = $Background
@onready var setting_buttons: Panel = $Background/SettingButtons
@onready var audio_visualB: Button = $Background/SettingButtons/Audio_Visual
@onready var gameplayB: Button = $Background/SettingButtons/Gameplay
@onready var quitB: Button = $Background/SettingButtons/Quit
@onready var exit_button: Button = $Background/SettingButtons/ExitButton
@onready var audio_visual: Panel = $Background/Audio_Visual
@onready var quit: Panel = $Background/Quit
@onready var yesb: Button = $Background/Quit/Yes
@onready var nob: Button = $Background/Quit/No
var player : CharacterBody2D

var settingOpened : bool = false
var exit : int = 0

func _ready():
	setting_buttons.visible = false
	background.visible = false
	player = get_tree().get_first_node_in_group("Player")

func _input(event):
	if event.is_action_pressed("Menu") and player.GameOver == false:
		_escape_button()
		
func _toggle_menu():
	settingOpened = !settingOpened
	if settingOpened:
		setting_buttons.visible = true
		background.visible = true
	else:
		setting_buttons.visible = false
		background.visible = false
		audio_visual.visible = false
		quit.visible = false

func _on_audio_visual_pressed() -> void:
	setting_buttons.visible = false
	audio_visual.visible = true

func _on_quit_pressed() -> void:
	setting_buttons.visible = false
	quit.visible = true

func _on_exit_button_pressed() -> void:
	
	if setting_buttons.visible == true:
		_exit_settings(setting_buttons, exit, false)
	elif audio_visual.visible == true:
		_exit_settings(audio_visual, setting_buttons, true)
	elif quit.visible == true:
		_exit_settings(quit, setting_buttons, true)
		
func _on_option_button_item_selected(index: int) -> void:
	match index:
		0: Engine.max_fps = 30
		1: Engine.max_fps = 60

func _on_window_item_selected(index: int) -> void:
	match index:
		0: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_exit_button_a_pressed() -> void:
	_exit_settings(audio_visual, setting_buttons, true)

func _on_yes_pressed() -> void:
	get_tree().quit()
	
func _on_no_pressed() -> void:
	_exit_settings(quit, setting_buttons, true)
	
func _exit_settings(exit_from,exit_to, bool_variable):
	exit_from.visible = false
	if bool_variable == true:
		exit_to.visible = true
	else: 
		_escape_button()
		
func _escape_button():
	get_tree().paused = !get_tree().paused
	print("Panel Position: ", self.position)
	_toggle_menu()
