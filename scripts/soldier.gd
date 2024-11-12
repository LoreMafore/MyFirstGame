extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var attack_1a = $AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1A
@onready var attack_1b = $AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1B
@onready var can_attack_timer: Timer = $canAttack
@onready var vertical_attack_timer: Timer = $verticalAttack
@onready var v_attack_a: CollisionShape2D = $AnimatedSprite2D/Hitboxes/VericalAttack/V_Attack_a
@onready var v_attack_b: CollisionShape2D = $AnimatedSprite2D/Hitboxes/VericalAttack/V_Attack_b
@onready var v_attack_c: CollisionShape2D = $AnimatedSprite2D/Hitboxes/VericalAttack/V_Attack_c
@onready var v_attack_d: CollisionShape2D = $AnimatedSprite2D/Hitboxes/VericalAttack/V_Attack_d
@onready var v_attack_e: CollisionShape2D = $AnimatedSprite2D/Hitboxes/VericalAttack/V_Attack_e
@onready var v_attack_f: CollisionShape2D = $AnimatedSprite2D/Hitboxes/VericalAttack/V_Attack_f
@onready var left = $Left
@onready var right = $Right


@export var isFacingRight : bool = false
@export var soldier : CharacterBody2D
@export var lengthOfPath : float = 25.0
@export var stayOnPlatform : float = true

var soldierInitPosition : float = 0.00
var canAttack : bool = true
var moveDirection = 1

func _ready():
	
	if isFacingRight == true:
		animated_sprite_2d.flip_h = true
		
	soldierInitPosition = soldier.global_position.x 

func _physics_process(delta):
	move_and_slide()
	
	if is_on_wall() or not left.is_colliding() or not right.is_colliding():
		animated_sprite_2d.flip_h = not animated_sprite_2d.flip_h
		
		
	if not is_on_floor():
		velocity.y = gravity * delta * 100
		
	if velocity.x != 0:
		animated_sprite_2d.play("Walking")
		
	_horizantal_attack_collison_position()
	_vertical_attack_collison_position()
		
	_horizantal_attack()
	_vertical_attack()

func _vertical_attack_collison_position():
	if animated_sprite_2d.flip_h == false:
		v_attack_a.position = Vector2(soldier.global_position.x + 12, soldier.global_position.y -10)
		v_attack_b.position = Vector2(soldier.global_position.x + 7, soldier.global_position.y -14)
		v_attack_c.position = Vector2(soldier.global_position.x + 2, soldier.global_position.y -15)
		v_attack_d.position = Vector2(soldier.global_position.x - 3, soldier.global_position.y -15)
		v_attack_e.position = Vector2(soldier.global_position.x - 8, soldier.global_position.y -13)
		v_attack_f.position = Vector2(soldier.global_position.x - 12, soldier.global_position.y -10)
		
	if animated_sprite_2d.flip_h == true:
		v_attack_a.position = Vector2(soldier.global_position.x - 12, soldier.global_position.y -10)
		v_attack_b.position = Vector2(soldier.global_position.x - 7, soldier.global_position.y -14)
		v_attack_c.position = Vector2(soldier.global_position.x - 2, soldier.global_position.y -15)
		v_attack_d.position = Vector2(soldier.global_position.x + 3, soldier.global_position.y -15)
		v_attack_e.position = Vector2(soldier.global_position.x + 8, soldier.global_position.y -13)
		v_attack_f.position = Vector2(soldier.global_position.x + 12, soldier.global_position.y -10)

func _horizantal_attack_collison_position():
	if animated_sprite_2d.flip_h == false:
		attack_1a.position = Vector2(soldier.global_position.x + 9, soldier.global_position.y + 10)
		attack_1b.position = Vector2(soldier.global_position.x + 15, soldier.global_position.y + 10)
	
	if animated_sprite_2d.flip_h == true:
		attack_1a.position = Vector2(soldier.global_position.x - 9, soldier.global_position.y  + 10)
		attack_1b.position = Vector2(soldier.global_position.x - 15, soldier.global_position.y + 10)

func _on_hozintal_attack_body_entered(body):
	body.damage(soldier.global_position.x)     
	
func _on_verical_attack_body_entered(body):
	body.damage(soldier.global_position.x)
	
	
func _horizantal_attack():
	if animated_sprite_2d.animation == "HorizantalAttack" and canAttack == true:
		# Check if the current frame is between 5 and 7
		if animated_sprite_2d.frame >= 5 and animated_sprite_2d.frame <= 7:
			attack_1a.disabled = false
			attack_1b.disabled = false
			canAttack = false
			can_attack_timer.start()

func _vertical_attack():
	if animated_sprite_2d.animation == "VerticalAttack" and canAttack == true:
		
		if animated_sprite_2d.frame >= 2 and animated_sprite_2d.frame <=3:
			v_attack_a.disabled = false
			v_attack_b.disabled = false
			v_attack_c.disabled = false
			v_attack_d.disabled = false
			v_attack_e.disabled = false
			v_attack_f.disabled = false
			vertical_attack_timer.start()

func _stay_on_platform(moveDirection):
	if is_on_wall() or not left.is_colliding() or not right.is_colliding():
		animated_sprite_2d.flip_h = not animated_sprite_2d.flip_h
		moveDirection *= -1

func _on_can_attack_timeout() -> void:
	#canAttack = true
	attack_1a.disabled = true
	attack_1b.disabled = true
	canAttack = true

func _on_vertical_attack_timeout() -> void:
	v_attack_a.disabled = true
	v_attack_b.disabled = true
	v_attack_c.disabled = true
	v_attack_d.disabled = true
	v_attack_e.disabled = true
	v_attack_f.disabled = true
	canAttack = true
