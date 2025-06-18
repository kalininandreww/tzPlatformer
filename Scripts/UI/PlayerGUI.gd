extends CanvasLayer

var startHealth:float = 1

@onready var heartContainer:HBoxContainer = %HeartContainer
@onready var heartScene:PackedScene = preload("res://Scenes/UI/heart.tscn")
@onready var killLabel:Label = %KillLabel
@onready var winLooseScreen:ColorRect = %WinLooseScreen
@onready var winLooseLabel:Label = %WinLooseLabel

var heartsPtrs:Array

func _ready() -> void:
	%WinLooseScreen.visible = false
	startHealth = get_parent().get_parent().health
	
	for i in range(0, startHealth):
		var heart = heartScene.instantiate()
		heartContainer.add_child(heart)
		heartsPtrs.append(heart)

func _on_health_changed(health:float) -> void:
	health = int(health)
	for i in range(heartsPtrs.size()):
		if i < health:
			heartsPtrs[i].changeIcon(false)
		else:
			heartsPtrs[i].changeIcon(true)
 
func updateKillCount(killCount:int)->void:
	killLabel.text = str(killCount)

func showWinLooseScreen(isWin:bool)->void:
	if isWin:
		winLooseLabel.text = "You win!"
	else:
		winLooseLabel.text = "You loose"
		Engine.time_scale = 0
	
	%WinLooseScreen.visible = true
	


func _on_restart_button_pressed() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
