extends State

@export var patrolState:State
@export var attackState:State

@onready var characterRay:RayCast2D = %CharacterRay
@onready var attackRay:RayCast2D = %AttackRay

func _physics_process(delta:float) -> void:
	var charRayCollider = characterRay.get_collider()
	var attackRayCollider = attackRay.get_collider()
	
	if charRayCollider and charRayCollider is PlayerCharacter:
		if attackRay and attackRayCollider is PlayerCharacter:
			stateMachine.switchStates(attackState)
		else:
			playerCharacter.follow(charRayCollider.position)
			playerCharacter.move_and_slide()
	else:
		stateMachine.switchStates(patrolState)
