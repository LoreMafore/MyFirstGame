extends StaticBody2D

@onready var spikes_damaged = $spikes_damaged

var player : CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("Player")	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spikes_damaged_body_entered(body):
	if body == player:
		body.damage(self.position.x, 1.5,1.5)
		
	#else:
		#print("die")
