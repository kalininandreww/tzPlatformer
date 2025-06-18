extends State

@onready var characterRay:RayCast2D = %CharacterRay

@export var followState:State

func _physics_process(delta: float) -> void:
	var charRayCollider = characterRay.get_collider()
	if charRayCollider and charRayCollider is PlayerCharacter:
		stateMachine.switchStates(followState)
	else:
		playerCharacter.patrol()
		playerCharacter.move_and_slide()
