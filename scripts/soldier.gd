extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var attack_1a = $AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1A
@onready var attack_1b = $AnimatedSprite2D/Hitboxes/HozintalAttack/Attack1B
@onready var can_attack_timer: Timer = $canAttack


@export var isFacingRight : bool = false
@export var soldier : CharacterBody2D
@export var lengthOfPath : float = 25.0

var soldierInitPosition : float = 0.00
var canAttack : bool = true

func _ready():
	
	if isFacingRight == true:
		animated_sprite_2d.flip_h = true
		
	soldierInitPosition = soldier.global_position.x 

func _physics_process(delta):
	move_and_slide()
	
	if not is_on_floor():
		velocity.y = gravity * delta * 100
		
	if velocity.x != 0:
		animated_sprite_2d.play("Walking")
		
	if animated_sprite_2d.flip_h == false:
		attack_1a.position = Vector2(soldier.global_position.x + 9, soldier.global_position.y + 10)
		attack_1b.position = Vector2(soldier.global_position.x + 15, soldier.global_position.y + 10)
	
	if animated_sprite_2d.flip_h == true:
		attack_1a.position = Vector2(soldier.global_position.x - 9, soldier.global_position.y  + 10)
		attack_1b.position = Vector2(soldier.global_position.x - 15, soldier.global_position.y + 10)
		
	_horizantal_attack()

func _on_hozintal_attack_body_entered(body):
	body.damage(soldier.global_position.x)     
	
func _horizantal_attack():
	if animated_sprite_2d.animation == "HorizantalAttack" and canAttack == true:
		# Check if the current frame is between 5 and 7
		if animated_sprite_2d.frame >= 5 and animated_sprite_2d.frame <= 7:
			attack_1a.disabled = false
			attack_1b.disabled = false
			
		else:
			attack_1a.disabled = true
			attack_1b.disabled = true
			
		if attack_1a.disabled == false:
			can_attack_timer.start()




func _on_can_attack_timeout() -> void:
	canAttack = true
