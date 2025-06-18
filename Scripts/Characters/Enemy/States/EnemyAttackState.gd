extends State

@export var attackWaitTime:float = 0.2
@export var followState:State
@export var  deadState:State
@export var attackAnim:String = "Attack"
@export var followAnim:String = "Move"

var preAttackTimer:Timer

func _ready() -> void:
	preAttackTimer = Timer.new()
	preAttackTimer.autostart = false
	preAttackTimer.one_shot = true
	preAttackTimer.timeout.connect(attackExecute)
	add_child(preAttackTimer)

func on_enter()->void:
	startAttack()

func attackExecute()->void:
	if stateMachine.currentState != deadState:
		playback.travel(attackAnim)

func startAttack()->void:
	preAttackTimer.start(attackWaitTime)

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	playback.travel(followAnim)
	stateMachine.switchStates(followState)
