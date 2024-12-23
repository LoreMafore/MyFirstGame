extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#references ti ither nodes
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var attack_1a = $AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1A
@onready var attack_1b = $AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1B
@onready var attack_1c = $AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1C
@onready var v_attack_a: CollisionShape2D = $AnimatedSprite2D/Hitboxes/VericalAttack/V_Attack_a
@onready var v_attack_b: CollisionShape2D = $AnimatedSprite2D/Hitboxes/VericalAttack/V_Attack_b
@onready var v_attack_c: CollisionShape2D = $AnimatedSprite2D/Hitboxes/VericalAttack/V_Attack_c
@onready var v_attack_d: CollisionShape2D = $AnimatedSprite2D/Hitboxes/VericalAttack/V_Attack_d
@onready var v_attack_e: CollisionShape2D = $AnimatedSprite2D/Hitboxes/VericalAttack/V_Attack_e
@onready var v_attack_f: CollisionShape2D = $AnimatedSprite2D/Hitboxes/VericalAttack/V_Attack_f
@onready var left = $Raycast/Left
@onready var right = $Raycast/Right
@onready var v_timer = $Timers/vTimer
@onready var h_timer = $Timers/hTimer
@onready var can_attack_timer = $Timers/canAttackTimer
@onready var h_detect = $AnimatedSprite2D/Hitboxes/hDetect
@onready var v_detect = $AnimatedSprite2D/Hitboxes/vDetect
@onready var seeing = $AnimatedSprite2D/Hitboxes/Seeing

#values can be changed in inspector
@export var isFacingRight : bool = false
@export var minion : CharacterBody2D
@export var lengthOfPath : float = 25.0
@export var stayOnPlatform : bool = true
@export var moveSpeed: float = 45.0 


#initalizing variables
var minionInitPositionX : float = 0.00
var canAttack : bool = true
var canAt : int = 1
var movementDirection = 1
var minionMovement : int 
var player : CharacterBody2D
var directionX : float = 0.00
var directionY : float = 0.00


func _ready():
		
		player = get_tree().get_first_node_in_group("Player")
		if player == null:
			print("Player node not found!")
			
func _process(delta):
	if animated_sprite_2d.flip_h == true:
			movementDirection = -1
			
	elif animated_sprite_2d.flip_h == false:
			movementDirection = 1
			
	if velocity.x != 0:
		animated_sprite_2d.play("Walking")

			
func _physics_process(delta):
	move_and_slide()
	
	#if isWalking == true:
	minionMovement = moveSpeed * movementDirection
		#velocity.x = minionMovement
	
	directionX = player.global_position.x- minion.global_position.x
	directionY = player.global_position.y - minion.global_position.y
	
	_horizantal_attack_collison_position()
	_vertical_attack_collison_position()
	_hitboxs()
	
	if not is_on_floor():
		velocity.y = gravity * delta * 100
	
	#facing 
	#if player.global_position.x > minion.global_position.x and player.position.y:
		#animated_sprite_2d.flip_h = false
		#movementDirection *= -1 
	#
	#elif player.global_position.x < minion.global_position.x and player.position.y:
		#animated_sprite_2d.flip_h = true
		#movementDirection *= -1 
		
#call this when leaving seeing area 2d
func _normalMovement():
	if minion.global_position.x < minionInitPositionX - lengthOfPath:
		animated_sprite_2d.flip_h == false 
		
	elif minion.global_position.x > minionInitPositionX + lengthOfPath:
		animated_sprite_2d.flip_h == true
	

func _on_v_detect_body_entered(body: Node2D) -> void:	
	#print("Help me V")
	if body.is_in_group("Player"):
		velocity.x = 0
		minion._vertical_attack()

func _on_h_detect_body_entered(body: Node2D) -> void: 
	#print("Help me H")
	if body.is_in_group("Player"):
		velocity.x = 0
		minion._horizantal_attack()
		
func _on_seeing_body_entered(body):
		if body.is_in_group("Player") and not animated_sprite_2d.is_playing():
			if player.global_position.x > minion.global_position.x and player.position.y:
				animated_sprite_2d.flip_h = false
				movementDirection *= -1 
	
			elif player.global_position.x < minion.global_position.x and player.position.y:
				animated_sprite_2d.flip_h = true
				movementDirection *= -1 
				
			velocity.x = minionMovement

func _vertical_attack_collison_position():
	if animated_sprite_2d.flip_h == false:
		v_attack_a.position = Vector2(minion.global_position.x + 12, minion.global_position.y -10)
		v_attack_b.position = Vector2(minion.global_position.x + 7, minion.global_position.y -14)
		v_attack_c.position = Vector2(minion.global_position.x + 2, minion.global_position.y -15)
		v_attack_d.position = Vector2(minion.global_position.x - 3, minion.global_position.y -15)
		v_attack_e.position = Vector2(minion.global_position.x - 8, minion.global_position.y -13)
		v_attack_f.position = Vector2(minion.global_position.x - 12, minion.global_position.y -10)
		
	if animated_sprite_2d.flip_h == true:
		v_attack_a.position = Vector2(minion.global_position.x - 12, minion.global_position.y -10)
		v_attack_b.position = Vector2(minion.global_position.x - 7, minion.global_position.y -14)
		v_attack_c.position = Vector2(minion.global_position.x - 2, minion.global_position.y -15)
		v_attack_d.position = Vector2(minion.global_position.x + 3, minion.global_position.y -15)
		v_attack_e.position = Vector2(minion.global_position.x + 8, minion.global_position.y -13)
		v_attack_f.position = Vector2(minion.global_position.x + 12, minion.global_position.y -10)

func _horizantal_attack_collison_position():
	if animated_sprite_2d.flip_h == false:
		attack_1a.position = Vector2(minion.global_position.x + 9, minion.global_position.y + 10)
		attack_1b.position = Vector2(minion.global_position.x + 15, minion.global_position.y + 10)
		attack_1c.position = Vector2(minion.global_position.x + 21, minion.global_position.y + 10)
	
	if animated_sprite_2d.flip_h == true:
		attack_1a.position = Vector2(minion.global_position.x - 9, minion.global_position.y  + 10)
		attack_1b.position = Vector2(minion.global_position.x - 15, minion.global_position.y + 10)
		attack_1c.position = Vector2(minion.global_position.x - 21, minion.global_position.y + 10)

func _hitboxs():
	if animated_sprite_2d.flip_h == false:
		h_detect.position = Vector2(global_position.x + 0, minion.global_position.y - 1)
		v_detect.position = Vector2(global_position.x + 0, minion.global_position.y + 10)
		seeing.position   = Vector2(global_position.x + 0, minion.global_position.y + 0)
		
	if animated_sprite_2d.flip_h == true:
		h_detect.position = Vector2(global_position.x - 30, minion.global_position.y - 1)
		v_detect.position = Vector2(global_position.x + 0, minion.global_position.y +10)
		seeing.position   = Vector2(global_position.x + 0, minion.global_position.y + 0)
		
func _on_hozintal_attack_body_entered(body):
	body.damage(minion.global_position.x)     
	
func _on_verical_attack_body_entered(body):
	body.damage(minion.global_position.x)

func _vertical_attack():
	if canAttack == true:
		
		animated_sprite_2d.play("VerticalAttack")
		_on_animated_sprite_2d_frame_changed()
	
func _horizantal_attack():
	if canAttack == true:
		animated_sprite_2d.play("HorizantalAttack")
		_on_animated_sprite_2d_frame_changed()

func _on_can_attack_timer_timeout():
	#print("Attack = true")
	canAttack = true

func _on_animated_sprite_2d_frame_changed():
	if animated_sprite_2d.animation == "HorizantalAttack":
		if animated_sprite_2d.frame >= 5 and animated_sprite_2d.frame <= 7:
			attack_1a.disabled = false
			attack_1b.disabled = false
			attack_1c.disabled = false
			canAttack = false
			can_attack_timer.start()
		
		elif animated_sprite_2d.frame <= 4 or animated_sprite_2d.frame >= 8:
			attack_1a.disabled = true
			attack_1b.disabled = true
			attack_1c.disabled = true
			
	if animated_sprite_2d.animation == "VerticalAttack":
		if animated_sprite_2d.frame >= 2 and animated_sprite_2d.frame <=3:
			v_attack_a.disabled = false
			v_attack_b.disabled = false
			v_attack_c.disabled = false
			v_attack_d.disabled = false
			v_attack_e.disabled = false
			v_attack_f.disabled = false
			canAttack = false
			can_attack_timer.start()
		
		else:
			v_attack_a.disabled = true
			v_attack_b.disabled = true
			v_attack_c.disabled = true
			v_attack_d.disabled = true
			v_attack_e.disabled = true
			v_attack_f.disabled = true

func _on_animated_sprite_2d_animation_finished():
	print("Hi")
	if animated_sprite_2d.animation == "HorizantalAttack":
		print("Bye")
		velocity.x = minionMovement
		
	elif animated_sprite_2d.animation == "VerticalAttack":
		velocity.x = minionMovement
