extends Node2D

const C_TIME_TILL_WAVE = 4

var g_waves = [load("res://Scenes/Arrow.tscn"), load("res://Scenes/Creata.tscn"), load("res://Scenes/DashWaveLeft.tscn"), load("res://Scenes/DashWaveRight.tscn"), load("res://Scenes/GroundLR.tscn"), load("res://Scenes/PlatformLR.tscn"), load("res://Scenes/UpDown.tscn"), load("res://Scenes/XForm.tscn")]
var g_time_passed = 2

func _physics_process(delta):
	
	g_time_passed = min(g_time_passed + delta, C_TIME_TILL_WAVE)
	
	if g_time_passed >= C_TIME_TILL_WAVE:
		spawn_wave()
		g_time_passed = 0


func spawn_wave():
	var wave = g_waves[randi() % g_waves.size()].instance()  
	add_child(wave)  