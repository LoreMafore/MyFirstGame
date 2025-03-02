extends Node
@onready var player = %Player

@onready var heals_label = $UI/Heals/HealsLabel
var healCounter : int = 3

func _ready():
	heals_label.text = str(healCounter) + "X"
	player = get_tree().get_first_node_in_group("Player")
	#if get_tree().current_scene == preload("res://scences/level_2.tscn"):
		#Global.hasDoubleJump = false
	
func _process(delta):
	if Input.is_action_just_pressed("Heal") and healCounter > 0 and healCounter < 4:
		if player.healthPoints != 3:
			healCounter -= 1
			heals_label.text = str(healCounter) + "X"
