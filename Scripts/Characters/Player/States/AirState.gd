extends State

@export var floorState:State
@export var floorAnimation:String = "Move"

func _physics_process(delta: float) -> void:
	if playerCharacter.is_on_floor():
		playback.travel(floorAnimation)
		stateMachine.switchStates(floorState)
