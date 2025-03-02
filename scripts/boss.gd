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
@onready var slam_detect = $AnimatedSprite2D/Hitboxes/slamDetect
@onready var slam_can_attack = $AnimatedSprite2D/Hitboxes/slamDetect/slam_can_attack
@onready var slam_attack = $AnimatedSprite2D/Hitboxes/SlamAttack
@onready var s_attack_collision_r = $AnimatedSprite2D/Hitboxes/SlamAttack/s_attack_collision_R
@onready var s_attack_collision_l = $AnimatedSprite2D/Hitboxes/SlamAttack/s_attack_collision_L
@onready var slamcooldown = $slamcooldown
@onready var slam = $AnimatedSprite2D/Hitboxes/Slam
@onready var slam_left = $AnimatedSprite2D/Hitboxes/SlamLeft
@onready var hozintal_attack = $AnimatedSprite2D/Hitboxes/HozintalAttack
@onready var slam_waves = $slamWaves

@export var weight: float = 0.01
@export var boss : CharacterBody2D
@export var boss_x_spd : int = 45
@export_range(-1,1) var facing_right : int = 1

const JMPSPD = -250
var stored_spd : int = 0
var player : CharacterBody2D
var can_attack : bool = true
var HA_collisions : Array = []
var VA_collisions : Array = []
enum actions { WALK, HORIZ, VERT, CHARGE, SLAM}
var current_action
var health = 3
var right_slam : bool = false
var left_slam : bool = false
var random_number : int = 0
var slam_waves_bool : bool = false
var slam_spd : float = 2
var charge_spd : float = 100

func _ready():
	
	player = get_tree().get_first_node_in_group("Player")
	if player == null:
		print("Player in NULL: line 23")
		get_tree().quit()
		
	stored_spd = boss_x_spd
	current_action = actions.WALK
		
func _process(delta):
	
	if health == 3:
		slam_spd = 2
		charge_spd = 100
		
		
	elif health == 2:
		slam_spd = 4
		charge_spd = 250
		set_modulate(Color(1,0.8,0.8,1))
	
	elif health == 1:
		slam_spd = 6
		charge_spd = 350
		set_modulate(Color(1,0,0,1))
	
	

	if slam.right_slam == false:
		right_slam = false

	if slam_left.left_slam == false:
		left_slam = false

	if right_slam == true:
		slam.position.x += slam_spd
			
	if left_slam == true:
		slam_left.position.x -= slam_spd
		
	

func _physics_process(delta):
	
	move_and_slide()
	
	_move_boss(delta)
	
	if current_action == actions.CHARGE:
		animated_sprite_2d.sprite_frames.set_animation_speed("walk", 14)
		
	else:
		animated_sprite_2d.sprite_frames.set_animation_speed("walk", 7)
	
	velocity.x = boss_x_spd * facing_right 
	
	_boss_collision_position()
	_horizantal_attack_collison_position()
	_vertical_attack_collison_position()
	_charge_attack_collision_position()
	_slam_attack_coollision_position()
	_animated_sprite_2d_postion()

func _walking_animation():
	#This function is called in _move_boss
	if velocity.x != 0:
		animated_sprite_2d.play("walk")
		
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

func _animated_sprite_2d_postion():
	if animated_sprite_2d.flip_h == true:
		animated_sprite_2d.position = Vector2(- 58, - 63)
		
	if animated_sprite_2d.flip_h == false:
		animated_sprite_2d.position = Vector2( 56, - 63)

func _horizantal_attack_collison_position():
	#sets postion of all horizantal hitboxes for the bosses attacks
	if animated_sprite_2d.flip_h == false:
		var collision_pos : Vector2 = Vector2(boss.global_position.x + 14,boss.global_position.y +7)
		
		h_attack_collision.position = Vector2(collision_pos.x + 41, collision_pos.y +.5)
		h_can_attack.position = Vector2(collision_pos.x + 42, collision_pos.y - 15)
		
	
	if animated_sprite_2d.flip_h == true:
		
		var collision_pos : Vector2 = Vector2(boss.global_position.x - 14,boss.global_position.y +7)
		
		h_attack_collision.position = Vector2(collision_pos.x - 41, collision_pos.y + .5)
		h_can_attack.position = Vector2(collision_pos.x - 42, collision_pos.y - 15)
		
func _vertical_attack_collison_position():
	#sets postion of all vertical hitboxes for the bosses attacks
	v_attack_collision.position = Vector2(boss.global_position.x, boss.global_position.y - 62)
	v_can_attack.position = Vector2(boss.global_position.x-1, boss.global_position.y - 77)
	
func _boss_collision_position():
	boss_collision.position = Vector2(boss.global_position.x, boss.global_position.y - 7)
	
func _charge_attack_collision_position():
	if animated_sprite_2d.flip_h == false:
		charge_can_attack.position = Vector2(boss.global_position.x + 300, boss.global_position.y - 29)
		
	if animated_sprite_2d.flip_h == true:
		charge_can_attack.position = Vector2(boss.global_position.x - 300, boss.global_position.y - 29)

func _slam_attack_coollision_position():
	if animated_sprite_2d.flip_h == false:
		slam_can_attack.position = Vector2(boss.global_position.x + 226, boss.global_position.y -62.5)

	if animated_sprite_2d.flip_h == true:
		slam_can_attack.position = Vector2(boss.global_position.x - 226, boss.global_position.y- 62.5)

	if right_slam == false:
		slam.global_position = Vector2(boss.global_position.x, boss.global_position.y + 1)
		
	if left_slam == false:
		slam_left.global_position = Vector2(boss.global_position.x - 116, boss.global_position.y + 1)

func _on_h_detect_body_entered(body):
	#enables attack and then has a short attack cool down
	if body == player and can_attack == true:
		can_attack = false
		current_action = actions.HORIZ
		h_can_attack.disabled = true
		boss_x_spd *= 0
		animated_sprite_2d.play("h_attack_animation")
		attack_cooldown.start()
		
func _on_v_detect_body_entered(body):
	if body == player and can_attack == true:
		can_attack = false
		current_action = actions.VERT
		v_can_attack.disabled = true
		boss_x_spd *= 0
		animated_sprite_2d.play("v_attack_animation")
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
	if current_action == actions.CHARGE and body.is_in_group("FinalSpikes"):
		health -= 1
		boss_x_spd *= 0
		charge_can_attack.disabled = true
		attack_cooldown.start()
	
	#normal player hitting
	if body == player:
		body.damage(boss.global_position.x, 0.5, 2)
		attack_cooldown.start()

func _on_charge_detect_body_entered(body):
	#enemy charges at player
	if can_attack == true:
		boss_x_spd += charge_spd
		h_detect.monitoring = false
		v_detect.monitoring = false
		slam_detect.set_deferred("monitoring", false)
		slam_can_attack.disabled = true
		charge_can_attack.disabled = true
		current_action = actions.CHARGE
		#attack_cooldown.start()
	
func _on_slam_detect_body_entered(body):
	random_number = randi_range(1, 3)
	if can_attack == true and random_number == 3:
		can_attack = false
		slam_waves_bool = true
		boss_x_spd *= 0
		boss.velocity.y = JMPSPD
		animated_sprite_2d.play("default")
		slam_detect.set_deferred("monitorable", false)
		slam_detect.set_deferred("monitoring", false)
		slam_can_attack.disabled = true
		current_action = actions.SLAM
		slam_waves.start()
		attack_cooldown.start()
		slamcooldown.start()

func _on_hozintal_attack_body_entered(body):
	if body == player:
		body.damage(boss.global_position.x, 1, 1.5)

func _on_verical_attack_body_entered(body):
	if body == player:
		body.damage(boss.global_position.x, 1, 1.5)
	#_vertical_enabled_attack()
				
func _on_attack_cooldown_timeout():
	#disables attacks and allows for boss to attack again
	
	if current_action == actions.HORIZ and h_can_attack.disabled == true:
		boss_x_spd = stored_spd
		h_can_attack.disabled = false
		current_action = actions.WALK
		can_attack = true
		
	elif current_action == actions.VERT and v_can_attack.disabled == true:
		print("goy")
		boss_x_spd = stored_spd
		v_can_attack.disabled = false
		current_action = actions.WALK
		can_attack = true
		
	elif current_action == actions.CHARGE and charge_can_attack.disabled == true:
		boss_x_spd = stored_spd
		h_detect.monitoring = true
		v_detect.monitoring = true
		slam_detect.set_deferred("monitoring", true)
		charge_can_attack.disabled = false
		slam_can_attack.disabled = false
		current_action = actions.WALK
		can_attack = true
		
	elif current_action == actions.SLAM and slam_can_attack.disabled == true:
		can_attack = true

func _on_slam_waves_timeout():
	if can_attack == false and slam_waves_bool == true:
		slam_waves_bool = false
		slam.right_slam = true
		slam_left.left_slam = true
		right_slam = true
		left_slam = true
		print("slaw wabes: ", can_attack)
		#slamcooldown.start()


func _on_slamcooldown_timeout():

	if current_action == actions.SLAM and slam_can_attack.disabled == true:
		print("goy boy")
		slam_detect.set_deferred("monitorable", true)
		slam_detect.set_deferred("monitoring", true)
		slam_can_attack.disabled = false
		boss_x_spd = stored_spd
		current_action = actions.WALK

func _on_animated_sprite_2d_frame_changed():
	if animated_sprite_2d.animation == "h_attack_animation":
		if animated_sprite_2d.frame >= 5 and animated_sprite_2d.frame <= 7:
			h_attack_collision.disabled = false
			
			
		elif animated_sprite_2d.frame > 7:
			animated_sprite_2d.play("default")
			h_attack_collision.disabled = true
			
	if animated_sprite_2d.animation == "v_attack_animation":
		if animated_sprite_2d.frame >= 5 and animated_sprite_2d.frame <= 8:
			v_attack_collision.disabled = false
			
			
		elif animated_sprite_2d.frame > 8:
			animated_sprite_2d.play("default")
			v_attack_collision.disabled = true
