extends Area2D

signal level_change(level)

export (PackedScene) var E_LEVEL

func _ready():
	print(get_tree().get_root().get_node("MainScene").name)
	connect("level_change", get_tree().get_root().get_node("MainScene"), "_on_level_change")



func _on_LevelChange_body_entered(body):
	if body.name == "Player":
		emit_signal("level_change", E_LEVEL)


