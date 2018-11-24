extends Node

signal level_change(level)

export (PackedScene) var E_LEVEL

func _ready():
	connect("level_change", get_tree().get_root().get_node("MainScene"), "_on_level_change")
	$Sprite.visible = false

func interact():
	emit_signal("level_change", E_LEVEL)

func _on_LevelChangeInteract_area_entered(area):
	print(area.name)
	if area.get_parent().name == "Player":
		$Sprite.visible = true


func _on_LevelChangeInteract_area_exited(area):
	if area.get_parent().name == "Player":
		$Sprite.visible = false
