extends CharacterBody2D

@export var slam_poly : CollisionPolygon2D

@onready var slam_attack = $SlamAttack
@onready var attack_col = $SlamAttack/attack_col
@onready var animated_sprite_2d = $AnimatedSprite2D

var player : CharacterBody2D

var right_slam : bool = false

#var new poly, for statement just doing opsite x shit 


func _ready():
	player = get_tree().get_first_node_in_group("Player")	

func _process(delta):
	if right_slam == false:
		slam_attack.set_collision_mask_value(4, false)
		slam_attack.set_collision_layer_value(4, false)
		animated_sprite_2d.visible = false
		
	elif right_slam == true:
		slam_attack.set_collision_mask_value(4, true)
		slam_attack.set_collision_layer_value(4, true)
		slam_attack.set_deferred("monitoring", true)
		animated_sprite_2d.visible = true

func _physics_process(delta):

	move_and_slide()

func _on_slam_attack_body_entered(body):
	if body == player:
		body.damage(self.global_position.x, 0.5, 0.5)
		slam_attack.set_deferred("monitoring", false)
		right_slam = false
	
	if body.is_in_group("FinalSpikes"):
		right_slam = false
	#if crsh into spikes stop
	
#func _change_shit():
	
