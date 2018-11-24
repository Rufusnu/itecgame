extends Node2D

# consts go here

const C_START_LEVEL = preload("res://Scenes/TestWorld.tscn")
const C_TEST_LEVEL = preload("res://Scenes/TestWorld.tscn")

# globals go here

var g_current_level = null

func _physics_process(delta):
	pass
	



func _on_Start_pressed():
	$Menu.queue_free()
	g_current_level = C_TEST_LEVEL.instance()
	add_child(g_current_level)
	

func _on_level_chance(level):
	g_current_level.queue_free()
	g_current_level = level.instance()
	add_child(g_current_level)
