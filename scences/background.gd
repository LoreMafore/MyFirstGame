extends Panel

@onready var audio_visual = $SettingButtons/Audio_Visual
@onready var gameplay = $SettingButtons/Gameplay
@onready var quit = $SettingButtons/Quit
@onready var setting_camera = $".."
@onready var camera_2d = $"../../Camera2D"

var selfOpened : bool = false

func _ready():
	self.visible = false

func _input(event):
	if event.is_action_pressed("Menu"):
		get_tree().paused = !get_tree().paused
		print("Panel Position: ", self.position)
		_toggle_menu()
		
func _toggle_menu():
	selfOpened = !selfOpened
	if selfOpened:
		self.visible = true
	else:
		self.visible = false
