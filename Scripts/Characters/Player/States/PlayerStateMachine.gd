extends Node

class_name PlayerStateMachine

var states:Array [State]
@export var currentState:State
@export var airState:State


var playerCharacter:CharacterBody2D
var animTree:AnimationTree

func _ready() -> void:
	playerCharacter = get_parent()
	animTree = %AnimationTree
	
	for child in get_children():
		if child is State:
			states.append(child)
			updateState(child)
	
	currentState.set_physics_process(true)

func updateState(state:State)->void:
	state.playerCharacter = playerCharacter
	state.stateMachine = self
	state.playerSpeed = playerCharacter.movementSpeed
	state.playerJumpVelocity = playerCharacter.jumpVelocity
	state.playback = animTree["parameters/playback"]
	state.set_physics_process(false)

func _physics_process(delta: float) -> void:
	if !playerCharacter.is_on_floor():
		switchStates(airState)

func switchStates(newState:State):
	currentState.set_physics_process(false)
	currentState = newState
	newState.set_physics_process(true)
	newState.on_enter()

func _input(event: InputEvent) -> void:
	currentState.state_input(event)
