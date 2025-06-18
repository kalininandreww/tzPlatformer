extends State

@export var airState:State
@export var jumpAnim:String = "Jump"

@export var attackState:State
@export var attackAnim:String = "Attack"

func state_input(event:InputEvent):
	if event.is_action_pressed("Jump"):
		playerCharacter.jump()
		playback.travel(jumpAnim)
		stateMachine.switchStates(airState)
	
	if event.is_action_pressed("Attack"):
		playerCharacter.attack()
		playback.travel(attackAnim)
		stateMachine.switchStates(attackState)
