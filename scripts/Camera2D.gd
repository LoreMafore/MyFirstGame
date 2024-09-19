extends Camera2D
@onready var camera_2d = $"."

var input_held_time_up = 0.0
var input_held_time_down = 0.0
var tempY : int = 0
var savePosition : bool = false
var hold_threshold = .5    # Time in seconds to trigger action
var cameraOffset: int = 50

func _process(delta):
	
	if Global.cameraMove == 1:
		camera_2d.zoom = Vector2(3,3)
		camera_2d.position.y = -16
		
	elif Global.cameraMove == 0:
		camera_2d.position.y = 0
		camera_2d.zoom = Vector2(4,4)
		
	elif Global.cameraMove == 2:
		camera_2d.zoom = Vector2(3.5,3.5)
		camera_2d.position.y = 0
	
	if Input.is_action_pressed("LookDown"):
		input_held_time_down += delta
		if input_held_time_down >= hold_threshold:
			_on_input_held_down()
			input_held_time_down = hold_threshold
			
	if Input.is_action_pressed("LookUp"):
		input_held_time_up += delta
		if input_held_time_up >= hold_threshold:
			_on_input_held_up()
			input_held_time_up = hold_threshold
	
	if Input.is_action_just_released("LookDown") and savePosition == true:
		
		camera_2d.position.y -= cameraOffset
		input_held_time_up = 0.0
		input_held_time_down = 0.0
		savePosition = false
			
	if Input.is_action_just_released("LookUp") and savePosition == true:
		
		camera_2d.position.y += cameraOffset
		input_held_time_up = 0.0
		input_held_time_down = 0.0
		savePosition = false


func _on_input_held_down():
	if not savePosition:
		tempY = camera_2d.position.y + cameraOffset
		savePosition = true
		
	# Move the camera until it reaches tempY
	if camera_2d.position.y < tempY:
		camera_2d.position.y += cameraOffset
	
	if camera_2d.position.y >= tempY:
		camera_2d.position.y = tempY
		
	
func _on_input_held_up():
	if not savePosition:
		tempY = camera_2d.position.y - cameraOffset
		savePosition = true
		
	# Move the camera until it reaches tempY
	if camera_2d.position.y > tempY:
		camera_2d.position.y -= cameraOffset
	
	if camera_2d.position.y <= tempY:
		camera_2d.position.y = tempY
	
