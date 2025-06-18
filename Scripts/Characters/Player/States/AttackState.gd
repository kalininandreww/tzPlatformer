extends State

@export var floorState:State
@export var floorAnimation:String = "Move"

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Attack":
		playback.travel(floorAnimation)
		stateMachine.switchStates(floorState)
