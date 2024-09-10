extends Area2D

@onready var timer = $Timer 
@onready var player = $"../../Player"
@onready var playerLevel2 = %Player


func _on_body_entered(body):
	timer.start()
	body.fallDamage()

func _on_timer_timeout():
	Engine.time_scale = 1
	if Global.level == 1:
		player.position.x = Global.placeHolderPositionX
		player.position.y = Global.placeHolderPositionY
		
	elif Global.level == 2:
		playerLevel2.position.x = Global.placeHolderPositionX
		playerLevel2.position.y = Global.placeHolderPositionY
		
	
