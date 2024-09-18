extends Area2D

@export var cameraPosition : Vector2
@export var collisionBig : Vector2
@export var cameraZoom : bool = false
@export var level2: bool = false
@export var cameraMove : bool = false
@onready var camera_2d = $"../../Player"
@onready var collision_shape_2d = $CollisionShape2D


#collision_shape_2d.transform.position = collisionBig

func _on_body_entered(body):
	if cameraZoom == true:
		camera_2d.zoom = cameraPosition
		
	if cameraMove == true and level2 == false:
		Global.cameraMove = 1
		
	elif cameraMove == true and level2 == true:
		Global.cameraMove = 2
	else: 
		Global.cameraMove = 0
	
	
