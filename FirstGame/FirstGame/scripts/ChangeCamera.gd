extends Area2D

@export var cameraPosition : Vector2
@export var collisionBig : Vector2
@export var cameraZoom : bool = false
@export var cameraMove : bool = false
@onready var camera_2d = $"../../Player"
@onready var collision_shape_2d = $CollisionShape2D


#collision_shape_2d.transform.position = collisionBig

func _on_body_entered(body):
	if cameraZoom == true:
		camera_2d.zoom = cameraPosition
		
		
	if cameraMove == true:
		Global.cameraMove = 1
		
	else: 
		Global.cameraMove = 0
	
	
