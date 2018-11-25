extends Node2D

# exporrts go here

export (PackedScene) var E_START_LEVEL 
export (PackedScene) var E_MENU

# consts go here

 

# globals go here

var g_current_level = null
var g_level = null

func _physics_process(delta):
	pass
	



func _on_Start_pressed():
	$Menu.queue_free()
	g_current_level = E_START_LEVEL.instance()
	add_child(g_current_level)
	

func _on_level_change(level):
	g_level = level
	g_current_level.queue_free()
	g_current_level = g_level.instance()
	add_child(g_current_level)
	

func reset():
	g_current_level.queue_free()
	g_current_level = g_level.instance()
	add_child(g_current_level)
	
func win():
	g_current_level.queue_free()
	var menu = E_MENU.instance()
	add_child(menu)
