extends CharacterBody2D


@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var h_attack_collision = $AnimatedSprite2D/Hitboxes/HozintalAttack/h_attack_collision
@onready var h_detect = $AnimatedSprite2D/Hitboxes/hDetect
@onready var h_can_attack = $AnimatedSprite2D/Hitboxes/hDetect/h_can_attack
@onready var attack_cooldown = $AttackCooldown
@onready var verical_attack = $AnimatedSprite2D/Hitboxes/VericalAttack
@onready var v_detect = $AnimatedSprite2D/Hitboxes/vDetect
@onready var v_attack_collision = $AnimatedSprite2D/Hitboxes/VericalAttack/V_Attack_collision
@onready var v_can_attack = $AnimatedSprite2D/Hitboxes/vDetect/v_can_attack
@onready var collision_shape_2d = $AnimatedSprite2D/Hitboxes/bossCollision/CollisionShape2D
@onready var boss_collision = $AnimatedSprite2D/Hitboxes/bossCollisionArea/bossCollision
@onready var charge_detect = $AnimatedSprite2D/Hitboxes/chargeDetect
@onready var charge_can_attack = $AnimatedSprite2D/Hitboxes/chargeDetect/charge_can_attack
@onready var slam_detectect = $AnimatedSprite2D/Hitboxes/slamDetect
@onready var slam_can_attack = $AnimatedSprite2D/Hitboxes/slamDetect/slam_can_attack
@onready var slam_attack = $AnimatedSprite2D/Hitboxes/SlamAttack
@onready var s_attack_collision = $AnimatedSprite2D/Hitboxes/SlamAttack/s_attack_collision



@export var boss : CharacterBody2D
@export var boss_x_spd : int = 45
@export_range(-1,1) var facing_right : int = 1

var stored_spd : int = 0
var player : CharacterBody2D
var can_attack : bool = true
var HA_collisions : Array = []
var VA_collisions : Array = []
enum actions { WALK, HORIZ, VERT, CHARGE, SLAM}
var current_action
var health = 3

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	if player == null:
		print("Player in NULL line 23")
		get_tree().quit()
		
	stored_spd = boss_x_spd
	current_action = actions.WALK
		
func _process(delta):
	print(current_action)
	#if current_action == actions.WALK:
		#_walking_animation()
	#_vertical_enabled_attack()

func _physics_process(delta):
	
	move_and_slide()
	
	_move_boss(delta)
	
	velocity.x = boss_x_spd * facing_right
	
	
	_boss_collision_position()
	_horizantal_attack_collison_position()
	_vertical_attack_collison_position()
	_charge_attack_collision_position()
	_slam_attack_coollision_position()
	
	
	#jump and then shockwave
	#running move where he runs into wall

func _walking_animation():
	#This function is called in _move_boss
	if velocity.x != 0:
		animated_sprite_2d.play("default")
		
	if facing_right == 1:
		animated_sprite_2d.flip_h = false
		
	elif facing_right == -1:
		animated_sprite_2d.flip_h = true

func _move_boss(delta):
	#function being called in _physics_process
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	if current_action == actions.WALK:
		if player.global_position.x < boss.global_position.x:
			facing_right = -1
			
		elif player.global_position.x > boss.global_position.x:
			facing_right = 1
			
		_walking_animation()

func _horizantal_attack_collison_position():
	#sets postion of all horizantal hitboxes for the bosses attacks
	if animated_sprite_2d.flip_h == false:
		var collision_pos : Vector2 = Vector2(boss.global_position.x + 14,boss.global_position.y +7)
		
		h_attack_collision.position = Vector2(collision_pos.x+41, collision_pos.y +.5)
		h_can_attack.position = Vector2(collision_pos.x + 15, collision_pos.y - 15)
		
	
	if animated_sprite_2d.flip_h == true:
		
		var collision_pos : Vector2 = Vector2(boss.global_position.x - 14,boss.global_position.y +7)
		
		h_attack_collision.position = Vector2(collision_pos.x-41, collision_pos.y + .5)
		h_can_attack.position = Vector2(collision_pos.x - 15, collision_pos.y - 15)
		
func _vertical_attack_collison_position():
	#sets postion of all vertical hitboxes for the bosses attacks
	v_attack_collision.position = Vector2(boss.global_position.x, boss.global_position.y - 62)
	v_can_attack.position = Vector2(boss.global_position.x, boss.global_position.y - 51.5)
	
func _boss_collision_position():
	boss_collision.position = Vector2(boss.global_position.x, boss.global_position.y - 7)
	
func _charge_attack_collision_position():
	if animated_sprite_2d.flip_h == false:
		charge_can_attack.position = Vector2(boss.global_position.x + 300, boss.global_position.y - 29)
		
	if animated_sprite_2d.flip_h == true:
		charge_can_attack.position = Vector2(boss.global_position.x - 300, boss.global_position.y - 29)

func _slam_attack_coollision_position():
	if animated_sprite_2d.flip_h == false:
		s_attack_collision.position = Vector2(boss.global_position.x + 110 , boss.global_position.y-17)
		slam_can_attack.position = Vector2(boss.global_position.x + 215, boss.global_position.y -5)

	if animated_sprite_2d.flip_h == true:
		s_attack_collision.position = Vector2(boss.global_position.x - 110 , boss.global_position.y-17)
		slam_can_attack.position = Vector2(boss.global_position.x - 215, boss.global_position.y- 5)


func _on_h_detect_body_entered(body):
	#enables attack and then has a short attack cool down
	if body == player and can_attack == true:
		current_action = actions.HORIZ
		h_attack_collision.disabled = false
		_horizontal_enabled_attack()
		h_can_attack.disabled = true
		can_attack = false
		attack_cooldown.start()
			
func _on_v_detect_body_entered(body):
	if body == player and can_attack == true:
		v_attack_collision.disabled = false
		current_action = actions.VERT
		_vertical_enabled_attack()
		v_can_attack.disabled = true
		can_attack = false
		attack_cooldown.start()

func _on_boss_collision_area_body_entered(body):
	
	#if hit by charge
	if current_action == actions.CHARGE and body == player:
		boss_x_spd *= 0
		body.damage(boss.global_position.x, 0.5, 2)
		charge_can_attack.disabled = true
		can_attack = false
		attack_cooldown.start()
	
	#if charge missing and runns into spikes
	if current_action == actions.CHARGE and body.is_in_group("FinalSikes"):
		health -= 1
		boss_x_spd *= 0
		charge_can_attack.disabled = true
		can_attack = false
		attack_cooldown.start()
	
	#normal player hitting
	if body == player and can_attack == true:
		body.damage(boss.global_position.x, 0.5, 2)
		can_attack = false
		attack_cooldown.start()

func _on_charge_detect_body_entered(body):
	#enemy charges at player
	if can_attack == true:
		boss_x_spd += 100
		h_detect.monitoring = false
		v_detect.monitoring = false
		current_action = actions.CHARGE
	
func _on_slam_detect_body_entered(body):
	pass # Replace with function body.
	
func _horizontal_enabled_attack():
	#called in v_detect_body_entered
	#damages the palyer
	if h_attack_collision.disabled == false:
		#comeback to this later, i would like this to be hozintal attack
		var bodies = h_detect.get_overlapping_bodies()
		for body in bodies:
			if body == player:
				body.damage(boss.global_position.x, 1, 1.5)

func _vertical_enabled_attack():
	#called in v_detect_body_entered
	#damages the palyer
	if v_attack_collision.disabled == false:
		#comeback to this later, i wouild like this to be vertical attack
		var bodies = v_detect.get_overlapping_bodies()
		for body in bodies:
			if body == player:
				body.damage(boss.global_position.x,1.5 ,1.5)
				
func _on_attack_cooldown_timeout():
	#disables attacks and allows for boss to attack again
	print("why")
	
	if current_action == actions.HORIZ and h_can_attack.disabled == true:
		h_attack_collision.disabled = true
		h_can_attack.disabled = false
		current_action = actions.WALK
		can_attack = true
		
	elif current_action == actions.VERT and v_can_attack.disabled == true:
		v_attack_collision.disabled = true
		v_can_attack.disabled = false
		current_action = actions.WALK
		can_attack = true
		
	elif current_action == actions.CHARGE and charge_can_attack.disabled == true:
		boss_x_spd = stored_spd
		h_detect.monitoring = true
		v_detect.monitoring = true
		charge_can_attack.disabled = false
		current_action = actions.WALK
		can_attack = true
		


func _on_slam_attack_body_entered(body):
	if body == player and can_attack == true:
		body.damage(boss.global_position.x, 0.5, 2)
		can_attack = false
		attack_cooldown.start()
