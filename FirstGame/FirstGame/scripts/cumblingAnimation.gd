extends AnimatedSprite2D

@onready var box: CollisionShape2D = $CharacterBody2D/CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $"."
@onready var respawn: Timer = $Respawn


func _on_frame_changed():
	if frame == 1:
		box.transform.origin += Vector2(0,1)
	
	#elif frame == 2:
	#	box.transform.origin += Vector2(0, 1)
		
	#elif frame == 3:
		#box.transform.origin += Vector2(0, 5)
	
	#elif frame == 4: 
		#ddbox.transform.origin += Vector2(0, )
		
	elif frame == 5:
		box.disabled = true

func _ready() -> void:
	frame_changed.connect(_on_frame_changed)

func _on_area_2d_body_entered(body: Node2D) -> void:
	animated_sprite_2d.play("crumbingNew")
	respawn.start()

func _on_respawn_timeout() -> void:
	animated_sprite_2d.play("0")
	box.disabled = false
