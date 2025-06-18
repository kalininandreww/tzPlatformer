extends CharacterBody2D

class_name PlayerCharacter

@export_category("Movement")
@export var movementSpeed:float = 150
@export var jumpVelocity:float = -350
@export_category("Combat Stats")
@export var health:float = 3
@export var damage:float = 50

@onready var animationPlayer:AnimationPlayer = %AnimationPlayer
@onready var animationTree:AnimationTree = %AnimationTree
@onready var sprite:Sprite2D = %Sprite2D
@onready var stateMachine:PlayerStateMachine = %StateMachine
@onready var attackArea:Area2D = %AttackArea
@onready var attackCollision:CollisionShape2D = %AttackCollision
@onready var UI:CanvasLayer = %UI

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var killCount:int = 0

func _ready() -> void:
	sprite.modulate = Color.DARK_SLATE_GRAY

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity*delta
	
	handleMovement()
	
	move_and_slide()
	
	handleAnimations()

func handleMovement()->void:
	
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	
	if direction:
		velocity.x = direction * movementSpeed
		if direction > 0:
			sprite.flip_h = false
			attackCollision.position.x = 12
		else:
			sprite.flip_h = true
			attackCollision.position.x = -12
	else:
		velocity.x = move_toward(velocity.x, 0, movementSpeed)

func jump()->void:
	velocity.y = jumpVelocity

func attack()->void:
	pass

func handleAnimations()->void:
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	animationTree.set("parameters/Move/blend_position", direction)

func die()->void:
	UI.showWinLooseScreen(false)

func win()->void:
	UI.showWinLooseScreen(true)

func increaseKillCount()->void:
	killCount+=1
	UI.updateKillCount(killCount)
