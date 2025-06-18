extends CharacterBody2D

@export var health:float = 100.0
@export var damage:float = 1.0
@export var collisionDamage:float = 1.0
@export var movementSpeed:float = 50.0
@export var chaseSpeed:float = 100.0
@export var jumpVelocity:float = -80.0
@export var deadState:State

@onready var sprite:Sprite2D = %Sprite2D
@onready var attackCollision:CollisionShape2D = %AttackCollision
@onready var animationTree:AnimationTree = %AnimationTree
@onready var animationPlayer:AnimationPlayer = %AnimationPlayer

@onready var rayCastNodes:Node2D = %RayCasts
@onready var edgeRay:RayCast2D = %EdgeRay

@onready var stateMachine = $StateMachine
@onready var attackState = $StateMachine/Attack

var currentDirection:float = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	%AnimationPlayer.play("Idle")

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity*delta
	
	updateAnimations()

func die()->void:
	stateMachine.switchStates(deadState)

func follow(targetPos:Vector2)-> void:
	var direction = (targetPos-position).normalized()
	velocity = direction * chaseSpeed

func patrol()-> void:
	var edgeRayCollider = edgeRay.get_collider()
	if edgeRayCollider and edgeRayCollider.is_in_group("Edge"):
		currentDirection *= -1
	velocity.x = currentDirection * movementSpeed
	if currentDirection > 0:
		sprite.flip_h = false
		attackCollision.position.x = 12
		rayCastNodes.rotation=0
	else:
		sprite.flip_h = true
		attackCollision.position.x = -12
		rayCastNodes.rotation=deg_to_rad(180)

func updateAnimations()->void:
	var moveBlend:float
	if stateMachine.currentState == attackState:
		moveBlend = 0
	else:
		moveBlend = 1
	animationTree.set("parameters/Move/blend_position", moveBlend)

func takeDamageEffects()->void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_method(setShaderBlinkIntensity,1.0, 0.0, 0.375)

func setShaderBlinkIntensity(newValue:float):
	sprite.material.set_shader_parameter("blinkIntetnsity", newValue)
