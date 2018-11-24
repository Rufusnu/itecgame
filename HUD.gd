extends CanvasLayer


func _on_Player_cd_over(power):
	if power == "jump":
		$Jump.modulate.a = 1
		return
	if power == "dash":
		$Dash.modulate.a = 1
		return
	if power == "attack":
		$Attack.modulate.a = 1
		return


func _on_Player_cd_start(power):
	if power == "jump":
		$Jump.modulate.a = 0.5
		return
	if power == "dash":
		$Dash.modulate.a = 0.5
		return
	if power == "attack":
		$Attack.modulate.a = 0.5
		return

func _on_Player_health_changed(hp):
	$HealthBar.value = hp


func _on_Player_make_visible(power, state):
	if power == "jump":
		$Jump.visible = state
		return
	if power == "dash":
		$Dash.visible = state
		return
	if power == "attack":
		$Attack.visible = state
		return