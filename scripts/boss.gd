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




@export var boss : CharacterBody2D
@export var boss_x_spd : int = 45
@export_range(-1,1) var facing_right : int = 1

var player : CharacterBody2D
var can_attack : bool = true
var HA_collisions : Array = []
var VA_collisions : Array = []

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	if player == null:
		print("Player in NULL line 23")
		get_tree().quit()
		
func _process(delta):
	_walking_animation()
	#_vertical_enabled_attack()

func _physics_process(delta):
	
	move_and_slide()
	
	_move_boss(delta)
	
	velocity.x = boss_x_spd * facing_right
	
	_boss_collision()
	_horizantal_attack_collison_position()
	_vertical_attack_collison_position()
	
	
	#up slash
	#jump and then shockwave
	#running move where he runs into wall

func _walking_animation():
	#This function is called in _process
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
	
func _boss_collision():
	boss_collision.position = Vector2(boss.global_position.x, boss.global_position.y - 7)
	
func _on_h_detect_body_entered(body):
	#enables attack and then has a short attack cool down
	if body == player and can_attack == true:
		h_attack_collision.disabled = false
		_horizontal_enabled_attack()
		h_can_attack.disabled = true
		can_attack = false
		attack_cooldown.start()
			
func _on_v_detect_body_entered(body):
	if body == player and can_attack == true:
		v_attack_collision.disabled = false
		_vertical_enabled_attack()
		v_can_attack.disabled = true
		can_attack = false
		attack_cooldown.start()

func _on_boss_collision_area_body_entered(body):
	if body == player and can_attack == true:
		body.damage(boss.global_position.x)
		can_attack = false
		attack_cooldown.start()

func _horizontal_enabled_attack():
	#called in v_detect_body_entered
	#damages the palyer
	if h_attack_collision.disabled == false:
		#comeback to this later, i would like this to be hozintal attack
		var bodies = h_detect.get_overlapping_bodies()
		for body in bodies:
			if body == player:
				body.damage(boss.global_position.x)

func _vertical_enabled_attack():
	#called in v_detect_body_entered
	#damages the palyer
	if v_attack_collision.disabled == false:
		#comeback to this later, i wouild like this to be vertical attack
		var bodies = v_detect.get_overlapping_bodies()
		for body in bodies:
			if body == player:
				body.damage(boss.global_position.x)
				
func _on_attack_cooldown_timeout():
	#disables attacks and allows for boss to attack again

	if h_can_attack.disabled == true:
		h_attack_collision.disabled = true
		h_can_attack.disabled = false
		
	elif v_can_attack.disabled == true:
		v_attack_collision.disabled = true
		v_can_attack.disabled = false
	
	can_attack = true
	
