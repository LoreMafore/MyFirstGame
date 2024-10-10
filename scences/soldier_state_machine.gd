extends Node

var currentState : State
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.Transitioned.connect(onChildTransitioned)
			
func _process(delta):
	if currentState:
		currentState.Update(delta)
		
func _physics_process(delta):
	if currentState:
		currentState.physicsUpdate(delta)
		
func onChildTransitioned(state, newStateName):
	if state !=  currentState:
		return
	
