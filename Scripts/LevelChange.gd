extends Area2D

signal level_chance(level)

export (PackedScene) var E_LEVEL


func _on_LevelChange_body_entered(body):
	if body.name == "Player":
		emit_signal("level_chance", E_LEVEL)


func _on_LevelChange_tree_entered():
	print(get_tree().get_root().get_node("MainScene").name)
	connect("level_chance", get_tree().get_root().get_node("MainScene"), "_on_level_chance")

