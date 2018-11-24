extends CanvasLayer


func _ready():
	$Start.connect("pressed", get_tree().get_root().get_node("MainScene"), "_on_Start_pressed")
