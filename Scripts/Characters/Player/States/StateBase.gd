extends Node

class_name State


var playerSpeed:float
var playerJumpVelocity:float

var playerCharacter:CharacterBody2D
var stateMachine:PlayerStateMachine

var playback:AnimationNodeStateMachinePlayback

func state_input(event:InputEvent):
	pass

func on_enter()->void:
	pass
