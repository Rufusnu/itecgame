extends Area2D

signal level_change(level)

export (PackedScene) var E_LEVEL

func _ready():
	connect("level_change", get_tree().get_root().get_node("MainScene"), "_on_level_change")



func _on_LevelChange_body_entered(body):
	print("Alune?")
	if body.name == "Player":
		print("Alune")
		emit_signal("level_change", E_LEVEL)


