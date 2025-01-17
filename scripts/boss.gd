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

func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	_horizantal_attack_collison_position()
	
	#up slash
	#jump and then shockwave
	#running move where he runs into wall

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
