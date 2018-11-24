extends Node

signal level_change(level)

export (PackedScene) var E_LEVEL

func _ready():
	connect("level_chance", get_tree().get_root().get_node("MainScene"), "_on_level_chance")

func interact():
	emit_signal("level_change", level)