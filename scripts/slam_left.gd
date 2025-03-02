extends CharacterBody2D
@onready var slam_attack = $SlamAttack
@onready var s_attack_collision = $SlamAttack/s_attack_collision
@onready var animated_sprite_2d = $AnimatedSprite2D

var player : CharacterBody2D

var left_slam : bool = false

#var new poly, for statement just doing opsite x shit 


func _ready():
	player = get_tree().get_first_node_in_group("Player")	

func _process(delta):
	if left_slam == false:
		slam_attack.set_collision_mask_value(4, false)
		slam_attack.set_collision_layer_value(4, false)
		animated_sprite_2d.visible = false
		
	elif left_slam == true:
		slam_attack.set_collision_mask_value(4, true)
		slam_attack.set_collision_layer_value(4, true)
		slam_attack.set_deferred("monitoring", true)
		animated_sprite_2d.visible = true

func _physics_process(delta):

	move_and_slide()

func _on_slam_attack_body_entered(body):
	print("gay")
	if body == player:
		body.damage(self.global_position.x, 0.5, 0.5)
		slam_attack.set_deferred("monitoring", false)
		left_slam = false
		
	if body.is_in_group("FinalSpikes"):
		left_slam = false
		
		
	#if crsh into spikes stop
