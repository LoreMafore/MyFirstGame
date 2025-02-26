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

@export var boss : CharacterBody2D
@export var boss_x_spd : int = 45
@export_range(-1,1) var facing_right : int = 1

var player : CharacterBody2D


func _ready():
	player = get_tree().get_first_node_in_group("Player")
	if player == null:
		print("Player in NULL line 23")
		get_tree().quit()
	
func _process(delta):
	_walking_animation()

func _physics_process(delta):
	
	move_and_slide()
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	_move_boss()
	
	velocity.x = boss_x_spd * facing_right
	
	
	
	_horizantal_attack_collison_position()
	
	
	
	
	#up slash
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

func _move_boss():
	
	if player.global_position.x < boss.global_position.x:
		facing_right = -1
		
	elif player.global_position.x > boss.global_position.x:
		facing_right = 1
		
		_walking_animation()


func _horizantal_attack_collison_position():
	if animated_sprite_2d.flip_h == false:
		attack_1a.position = Vector2(boss.global_position.x + 14, boss.global_position.y + 7)
		attack_1b.position = Vector2(boss.global_position.x + 26, boss.global_position.y + 7)
		attack_1c.position = Vector2(boss.global_position.x + 38, boss.global_position.y + 7)
		attack_1d.position = Vector2(boss.global_position.x + 50, boss.global_position.y + 7)
		attack_1e.position = Vector2(boss.global_position.x + 62, boss.global_position.y + 7)
		attack_1f.position = Vector2(boss.global_position.x + 74, boss.global_position.y + 7)
		attack_1g.position = Vector2(boss.global_position.x + 86, boss.global_position.y + 7)
		attack_1h.position = Vector2(boss.global_position.x + 98, boss.global_position.y + 7)
	
	if animated_sprite_2d.flip_h == true:
		attack_1a.position = Vector2(boss.global_position.x - 14, boss.global_position.y + 7)
		attack_1b.position = Vector2(boss.global_position.x - 26, boss.global_position.y + 7)
		attack_1c.position = Vector2(boss.global_position.x - 38, boss.global_position.y + 7)
		attack_1d.position = Vector2(boss.global_position.x - 50, boss.global_position.y + 7)
		attack_1e.position = Vector2(boss.global_position.x - 62, boss.global_position.y + 7)
		attack_1f.position = Vector2(boss.global_position.x - 74, boss.global_position.y + 7)
		attack_1g.position = Vector2(boss.global_position.x - 86, boss.global_position.y + 7)
		attack_1h.position = Vector2(boss.global_position.x - 98, boss.global_position.y + 7)
