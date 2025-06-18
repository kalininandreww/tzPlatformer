extends Node
class_name HealthComponent

signal healthChanged(health:float) 

var health:float = 1.0

func _ready() -> void:
	if "health" in get_parent():
		health = get_parent().health
	else:
		push_error(self.name + "'s parent ("+get_parent().name +") has no health")

func getHit(damage:float)->bool:
	health -= damage
	healthChanged.emit(health)
	if get_parent().has_method("takeDamageEffects"):
		get_parent().takeDamageEffects()
	if health <= 0:
		get_parent().die()
		return true
	else:
		return false
