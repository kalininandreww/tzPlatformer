extends Area2D

var damage:float = 1.0
var parent:CharacterBody2D

func _ready() -> void:
	if "collisionDamage" in get_parent():
		damage = get_parent().damage
	else:
		push_error(self.name + "'s parent ("+get_parent().name +") has no collision damage")
	
	parent = get_parent()


func _on_body_entered(body: Node2D) -> void:
	if body == parent:
		return
	
	for child in body.get_children():

		if child is HealthComponent:
			child.getHit(damage)
