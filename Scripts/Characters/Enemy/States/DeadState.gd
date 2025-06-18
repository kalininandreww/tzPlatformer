extends State

@export var deathAnim:String = "Dead"
@export var collisionsArray:Array[CollisionShape2D]

func on_enter()->void:
	playback.travel(deathAnim)
	for col in collisionsArray:
		col.set_deferred("disabled", true)


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == deathAnim:
		playerCharacter.queue_free()
