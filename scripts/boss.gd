extends CharacterBody2D


@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var attack_1a = $AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1A
@onready var attack_1b = $AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1B
@onready var attack_1c = $AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1C
@onready var attack_1d = $AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1D
@onready var attack_1e = $AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1E
@onready var attack_1f = $AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1F
@onready var attack_1g = $AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1G
@onready var attack_1h = $AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1H
@onready var h_can_attack = $AnimatedSprite2D/Hitboxes/hDetect/h_can_attack
@onready var attack_cooldown = $AttackCooldown
@onready var v_attack_a = $AnimatedSprite2D/Hitboxes/VericalAttack/V_Attack_a
@onready var v_attack_b = $AnimatedSprite2D/Hitboxes/VericalAttack/V_Attack_b
@onready var v_attack_c = $AnimatedSprite2D/Hitboxes/VericalAttack/V_Attack_c
@onready var v_attack_d = $AnimatedSprite2D/Hitboxes/VericalAttack/V_Attack_d


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
		

	#horizontal attack collisions
	HA_collisions = [attack_1a, attack_1b, attack_1c, attack_1d,
					 attack_1e, attack_1f, attack_1g, attack_1h]
					
	VA_collisions = [v_attack_a, v_attack_b, v_attack_c, v_attack_d,]

func _process(delta):
	_walking_animation()

func _physics_process(delta):
	
	move_and_slide()
	
	_move_boss(delta)
	
	velocity.x = boss_x_spd * facing_right
	
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
	#sets postion of all vertical hitboxes for the bosses attacks
	if animated_sprite_2d.flip_h == false:
		var collision_pos : Vector2 = Vector2(boss.global_position.x + 14,boss.global_position.y +7)
		
		h_can_attack.position = Vector2(collision_pos.x + 15, collision_pos.y - 15)
		
		for i in range(HA_collisions.size()):
			if HA_collisions[i] == null:
				print("Warning: HA_collisions[", i, "] is null")
				return 
			HA_collisions[i].position = Vector2(collision_pos.x, collision_pos.y)
			collision_pos.x += 12
	
	if animated_sprite_2d.flip_h == true:
		
		var collision_pos : Vector2 = Vector2(boss.global_position.x - 14,boss.global_position.y +7)
		
		h_can_attack.position = Vector2(collision_pos.x - 15, collision_pos.y - 15)
		
		for i in range(HA_collisions.size()):
			if HA_collisions[i] == null:
				print("Warning: HA_collisions[", i, "] is null")
				return 
			HA_collisions[i].position = Vector2(collision_pos.x, collision_pos.y)
			collision_pos.x -= 12

func _vertical_attack_collison_position():
	
	var collision_pos : Vector2 = Vector2(boss.global_position.x , boss.global_position.y - 28)
	
	for i in range(VA_collisions.size()):
		
		VA_collisions[i].position =  Vector2(collision_pos)
		collision_pos.y -= 12
	
		
		

func _on_h_detect_body_entered(body):
	#enables attack and then has a short attack cool down
	if body == player and can_attack == true:
		for i in range(HA_collisions.size()):
			HA_collisions[i].disabled = false
		h_can_attack.disabled = true
		can_attack = false
		attack_cooldown.start()
			

#isnt working but got to move on
func _on_hozintal_attack_body_entered(body):
	print("Help")
	if body == player:
		print("Gay")
		body.damage(boss.global_position.x)  


func _on_attack_cooldown_timeout():
	#disables attacks and allows for boss to attack again
	for i in range(HA_collisions.size()):
		HA_collisions[i].disabled = true
	h_can_attack.disabled = false
	can_attack = true
	
	
	
	
