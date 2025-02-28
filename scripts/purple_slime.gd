extends CharacterBody2D

var isAlive = true
var stopped = 1
var ogPosition : Vector2
var deltaTime : float = 0.00


@export var SPEED = 45
@export var direction = 50	
@export var stayOnPlatform: bool 
@export var jumpDirection : float = -300.0
@export var respawn: bool 
@onready var timer = $Timer
@onready var dead = $dead
@onready var purple_slime = $"."
@onready var collision_shape_2d = $CollisionShape2D
@onready var collision_shape_2d_2 = $CollisionShape2D2
@onready var top_checker = $TopChecker
@onready var sides_checkers = $SidesCheckers
@onready var player = %Player



var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	
	ogPosition = purple_slime.position
	
	if direction < 0: 
		$AnimatedSprite2D.flip_h = true

func _physics_process(delta):
	deltaTime = delta
	
	if isAlive == true:
		if stayOnPlatform == true:
			if is_on_wall() or not $BottomLeft.is_colliding() or not $BottomRight.is_colliding():
				direction *= -1
				$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h
		else: 
			if is_on_wall():
				direction *= -1
				$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h	
			
		if not is_on_floor():
			velocity.y += gravity * delta
		
		$AnimatedSprite2D.play("default")
		
	velocity.x = SPEED * direction * delta * stopped	

	move_and_slide()

func _on_top_checker_body_entered(body):
	isAlive = false
	$AnimatedSprite2D.play("Damaged")
	stopped = 0
	set_collision_layer_value(1,false)
	set_collision_mask_value(1,false)

	body.bounce(jumpDirection)
		
	dead.start()

func _on_sides_checkers_body_entered(body):
	body.damage(position.x, 0.5, 1)

func _on_timer_timeout():
	purple_slime.position = Vector2(ogPosition)
	purple_slime.visible = true
	isAlive = true
	stopped = 1

func _on_dead_timeout():
	purple_slime.visible = false
	purple_slime.position = Vector2(-1000, -1000)
	if respawn == true:
		timer.start()
