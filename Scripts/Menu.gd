extends CanvasLayer


func _ready():
	$Start.connect("pressed", get_tree().get_root().get_node("MainScene"), "_on_Start_pressed")

func _input(event):
	if event is InputEventKey and event.pressed and event.as_text() == "Enter":
		$Start.emit_signal("pressed")