extends Control

@onready var level_select_menu = $"../LevelSelectMenu"
@onready var menu_screen = $"."
@onready var setting_menu = $"../SettingMenu"

func _ready():
	level_select_menu.visible = false
	setting_menu.visible = false

func _on_exit_b_pressed():
	_exit()

func _on_level_select_pressed():
	_exit_settings(menu_screen, level_select_menu)

func _on_setting_pressed():
	_exit_settings(menu_screen, setting_menu)

func _on_quit_m_ain_menu_pressed():
	get_tree().quit()

func _exit_settings(exit_from,exit_to):
	exit_from.visible = false
	exit_to.visible = true

func _exit():
	setting_menu.visible = false
	level_select_menu.visible = false
	menu_screen.visible = true
	
	
