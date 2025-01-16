extends CharacterBody2D

const MOVESPD = 130.0
const FALLSPD = 120.0
const JUMPSPD = -250
const JUMP_DAMAGED = -190.0
var MAX_HEALS = 3

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var healthPoints : int = 3
var heals: int = 3
var currentSpeed : int = 0.00
var canDoubleJump: int = 0
var lastFrame : int = -1
var jumpBuffer : bool = false
var canJump : bool = false
var canInput : bool = true
var deltaTime : float = 0.00
var GameOver = false 

@export var facing: bool = false 
@export var ifHasDoubleJump : bool 
@export var doubleJumpMultiplfier : float = .5
@onready var animated_sprite = $AnimatedSprite2D
@onready var hearts2_knight = $"../GameManager/UI/Life/Hearts2_Knight"
@onready var hearts1_knight = $"../GameManager/UI/Life/Hearts1_Knight"
@onready var hearts3_knight = $"../GameManager/UI/Life/Hearts3_Knight"
@onready var player = $"."
@onready var timer = $Timer
@onready var fall_damage_timer = $FallDamageTimer
@onready var coyote_timer = $CoyoteTimer
@onready var input_timer: Timer = $InputTimer
@onready var jump_buffer: Timer = $JumpBuffer
@onready var death_screen = $"../GameManager/UI/ColorRect/DeathScreen"

func _ready():
	if Global.hasDoubleJump == true:
		ifHasDoubleJump = true
	
	if facing == true:
		animated_sprite.flip_h = true
		
	else: 
		animated_sprite.flip_h = false
		
	GameOver = false
	
	get_tree().paused = false

func _physics_process(delta):
	
	deltaTime = delta
	
	if canInput == true:
		if Input.is_action_just_pressed("Heal"):
			if healthPoints >= 1 and healthPoints < MAX_HEALS and heals >= 1:
				heal()
			else:
				print("Heal")
		
		#Gravity
		if not is_on_floor():
			#animated_sprite.play("Jump")
			if canJump == true:
				if coyote_timer.is_stopped():
					coyote_timer.start()
				
			velocity.y += gravity * delta
			if ifHasDoubleJump == true:
				canDoubleJump += 1
				doubleJump()
				jumpBuffer = false
		
		else: 
			canJump = true
			coyote_timer.stop()
			if jumpBuffer == true:
				jump()
				jumpBuffer = false
			
		if is_on_floor():
			canDoubleJump = 0
		
		if Input.is_action_just_pressed("jump"):
			if canJump == true:
				jump()
			else:
				jumpBuffer = true
				jump_buffer.start()
		#facing
		var direction = Input.get_axis("moveLeft", "moveRight")
		
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true	

		#moving left or right
		if direction:
				
			if is_on_floor():
				currentSpeed = MOVESPD
				velocity.x = direction * currentSpeed 
				animated_sprite.play("Run")
			
			else:	
				velocity.x = direction * FALLSPD
		else:
			velocity.x = move_toward(velocity.x, 0, MOVESPD)

			if is_on_floor() and direction == 0:
				animated_sprite.play("Idle")
			
		
		move_and_slide()
	
	else:
		input_timer.start()
func jump():
		velocity.y = JUMPSPD 
		animated_sprite.play("Jump")
	
func doubleJump():
	if canDoubleJump >= 1 and Input.is_action_just_pressed("jump"):
		if velocity.y > JUMPSPD:
			velocity.y = JUMPSPD
		velocity.y += JUMPSPD *doubleJumpMultiplfier
		canDoubleJump = -1000
	
func bounce(JumpDamaged):
	velocity.y = JumpDamaged 
	
func fallDamage():
	healthPoints -= 1
	
	if healthPoints == 2:
		hearts3_knight.texture = ResourceLoader.load("res://brackeys_platformer_assets/sprites/HeartKnight.png")
		
	elif healthPoints == 1:
		hearts2_knight.texture = ResourceLoader.load("res://brackeys_platformer_assets/sprites/HeartKnight.png")
	
	elif healthPoints <= 0:
		hearts1_knight.texture = ResourceLoader.load("res://brackeys_platformer_assets/sprites/HeartKnight.png")
		_beforeDeath()
		
	fall_damage_timer.start()
	
func heal():
	heals -= 1
	healthPoints += 1
	
	if healthPoints == 3:
		hearts3_knight.texture = ResourceLoader.load("res://brackeys_platformer_assets/sprites/FullKnightHearts.png")
		
	elif healthPoints == 2:
		hearts2_knight.texture = ResourceLoader.load("res://brackeys_platformer_assets/sprites/FullKnightHearts.png")
	
func damage(enemenyPosX):

	healthPoints -= 1
	
	if healthPoints == 2:
		hearts3_knight.texture = ResourceLoader.load("res://brackeys_platformer_assets/sprites/HeartKnight.png")
		
	elif healthPoints == 1:
		hearts2_knight.texture = ResourceLoader.load("res://brackeys_platformer_assets/sprites/HeartKnight.png")
	
	elif healthPoints <= 0:
		hearts1_knight.texture = ResourceLoader.load("res://brackeys_platformer_assets/sprites/HeartKnight.png")
		_beforeDeath()
		
	timer.start()
	set_modulate(Color(1,0.3,0.3,1))
	velocity.y = JUMP_DAMAGED * 0.5
	
	if player.global_position.x < enemenyPosX:
		velocity.x = -800
		Input.action_release("moveRight")
	
	elif player.global_position.x > enemenyPosX:
		velocity.x += 800
		Input.action_release("moveLeft")

func spikesDamage1(spikePosX, spikeBounce):
	healthPoints -= 1
	
	if healthPoints == 2:
		hearts3_knight.texture = ResourceLoader.load("res://brackeys_platformer_assets/sprites/HeartKnight.png")
		
	elif healthPoints == 1:
		hearts2_knight.texture = ResourceLoader.load("res://brackeys_platformer_assets/sprites/HeartKnight.png")
	
	elif healthPoints <= 0:
		hearts1_knight.texture = ResourceLoader.load("res://brackeys_platformer_assets/sprites/HeartKnight.png")
		_beforeDeath()
		
	timer.start()

	set_modulate(Color(1,0.3,0.3,1))
	velocity.y = JUMP_DAMAGED * 0.5
	
	if player.global_position.x < spikePosX:
		velocity.x = -spikeBounce
		Input.action_release("moveRight")
	
	elif player.global_position.x > spikePosX:
		velocity.x += spikeBounce
		Input.action_release("moveLeft")

func spikesDamage2():
	healthPoints -= 1
	
	if healthPoints == 2:
		hearts3_knight.texture = ResourceLoader.load("res://brackeys_platformer_assets/sprites/HeartKnight.png")
		
	elif healthPoints == 1:
		hearts2_knight.texture = ResourceLoader.load("res://brackeys_platformer_assets/sprites/HeartKnight.png")
	
	elif healthPoints <= 0:
		hearts1_knight.texture = ResourceLoader.load("res://brackeys_platformer_assets/sprites/HeartKnight.png")
		_beforeDeath()

	timer.start()

func _on_timer_timeout():
	set_modulate(Color(1,1,1,1))
	if healthPoints <= 0:
		_death()

func _on_fall_damage_timer_timeout():
	if healthPoints <= 0:
		Global.cameraMove = 0
		_death()

func _on_coyote_timer_timeout():
	canJump = false
	canDoubleJump = 2
	doubleJump()
	coyote_timer.stop()

func _on_jump_buffer_timeout():
	jumpBuffer = false
	
func doubleJumpOn():
	ifHasDoubleJump = true

func _on_input_timer_timeout() -> void:
	canInput = true

func _death():
	Engine.time_scale = 1
	get_tree().paused = !get_tree().paused
	GameOver = true
	death_screen.visible = true

func _beforeDeath():
	Engine.time_scale = 0.5
	get_node("CollisionShape2D").queue_free()
