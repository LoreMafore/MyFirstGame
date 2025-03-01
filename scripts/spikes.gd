extends AnimatableBody2D

@export var checkPoint : bool = false
@export var spikeBounce: int = 500
@onready var turn_off_input = $TurnOffInput

var player : CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("Player")	


func _on_tips_body_entered(body):
	
	if body == player:
	
		if checkPoint == true:
			body.spikesDamage2()
			#turn_off_input.start()
			
			body.position.x = Global.placeHolderPositionX
			body.position.y = Global.placeHolderPositionY
		else:
			body.spikesDamage1(position.x, spikeBounce)



func _on_turn_off_input_timeout():
	get_tree().paused = false
