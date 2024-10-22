extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var attack_1a = $AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1A
@onready var attack_1b = $AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1B


@export var isFacingRight : bool = false
@export var soldier : CharacterBody2D
@export var lengthOfPath : float = 25.0

var soldierInitPosition : float = 0.00

func _ready():
	
	
	if isFacingRight == true:
		animated_sprite_2d.flip_h = true
		
	soldierInitPosition = soldier.global_position.x 
	
	#attack_1a.disabled = true
	#attack_1b.disabled = true

func _physics_process(delta):
	move_and_slide()
	
	if not is_on_floor():
		velocity.y = gravity * delta * 100
		
	if velocity.x != 0:
		animated_sprite_2d.play("Walking")
		
	if animated_sprite_2d.flip_h == false:
		attack_1a.position = Vector2(soldier.global_position.x + 9, soldier.global_position.y + 8)
		attack_1b.position = Vector2(soldier.global_position.x + 15, soldier.global_position.y +8)
	
	if animated_sprite_2d.flip_h == true:
		attack_1a.position = Vector2(soldier.global_position.x - 9, soldier.global_position.y  + 8)
		attack_1b.position = Vector2(soldier.global_position.x - 15, soldier.global_position.y + 8)

func _on_hozintal_attack_body_entered(body):
	body.damage(soldier.global_position.x)     
