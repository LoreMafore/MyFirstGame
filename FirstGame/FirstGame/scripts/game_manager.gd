extends Node

@onready var heals_label = $UI/Heals/HealsLabel
var healCounter : int = 3

func _ready():
	heals_label.text = str(healCounter) + "X"
	
func _process(delta):
	if Input.is_action_just_pressed("Heal") and healCounter > 0 and healCounter < 4:
		healCounter -= 1
		heals_label.text = str(healCounter) + "X"
