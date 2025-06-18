extends Area2D

var damage:float = 1.0
var parent:CharacterBody2D

func _ready() -> void:
	if "damage" in get_parent():
		damage = get_parent().damage
	else:
		push_error(self.name + "'s parent ("+get_parent().name +") has no damage")
	
	parent = get_parent()
	monitoring = false


func _on_body_entered(body: Node2D) -> void:
	if body == parent:
		return
	for child in body.get_children():
		if child is HealthComponent:
			var killed = child.getHit(damage)
			if killed: 
				if get_parent().has_method("increaseKillCount"):
					get_parent().increaseKillCount()
