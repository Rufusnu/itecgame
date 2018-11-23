extends KinematicBody2D


# exports go here
export (int) var E_MAX_WALK_SPEED
export (int) var E_ACCEL

export (int) var E_MAX_FALL_SPEED
export (int) var E_MAX_JUMP_SPEED
export (int) var E_JUMP_SPEED
export (int) var E_GRAVITY

export (int) var E_DASH_SPEED
export (bool) var E_HAS_DASH
export (bool) var E_HAS_DOUBLE_JUMP

export (int) var E_HEALTH

# consts go here

const C_NORMAL = Vector2(0, -1)

const C_COMBO_TIMEOUT = 0.2
const C_MAX_COMBO_CHAIN = 2

const C_DASH_CD = 1
const C_MAX_JUMPS = 2



# globals go here
var g_velocity = Vector2()
var g_dash_velocity = Vector2()

var g_facing_right = true

var g_key_combo = []
var g_combo_timer = 0

var g_dash_timer = 2
var g_jump_number = 0

var g_health = E_HEALTH

# moon walk

var g_is_moon_walking = false

func _input(event):
	# makes a buffer with the last C_MAX_COMBO_CHAIN keys pressed
	if event is InputEventKey and event.pressed and !event.echo: 
		
		g_key_combo.append(event.as_text())                     
		if g_key_combo.size() > C_MAX_COMBO_CHAIN:               
			g_key_combo.pop_front()
		                                 
		g_combo_timer = 0                                   

func _physics_process(delta):
	
	#movement suff
	
	var on_floor = is_on_floor()
	var on_ceiling = is_on_ceiling()
	var on_wall = is_on_wall()
	
	var move_right = Input.is_action_pressed("ui_right")
	var move_left = Input.is_action_pressed("ui_left")
	var move_jump = Input.is_action_just_pressed("ui_up")
	var moon_walk = Input.is_action_just_pressed("ui_moon")
	
	
	if move_right:
		g_velocity.x = min(g_velocity.x + E_ACCEL, E_MAX_WALK_SPEED)
		g_facing_right = true
		# anim stuff
	
	if move_left:
		g_velocity.x = max(g_velocity.x - E_ACCEL, -E_MAX_WALK_SPEED)
		g_facing_right = false
		# anim stuff
	# special
	## double jump
	if on_floor:
		if E_HAS_DOUBLE_JUMP:
			g_jump_number = C_MAX_JUMPS
		else:
			g_jump_number = 1
	
	if move_jump and g_jump_number > 0:
		g_velocity.y = max(g_velocity.y - E_JUMP_SPEED, -E_MAX_JUMP_SPEED)
		g_jump_number -= 1
		# anim stuff
		
	# too much gravity
	if on_floor:
		g_velocity.y = min(g_velocity.y + E_ACCEL, 15)
	else:
		g_velocity.y = min(g_velocity.y + E_GRAVITY, E_MAX_FALL_SPEED)
	
	if on_ceiling:
		g_velocity.y = 0
	
	
	if !move_right and !move_left:
		if on_floor:
			g_velocity.x = lerp(g_velocity.x, 0, 0.2)
		else:
			g_velocity.x = lerp(g_velocity.x, 0, 0.03)
	
	move_and_slide(g_velocity + g_dash_velocity, C_NORMAL)
	# end of movement
	
	
	# probably more anim stuff
	if g_is_moon_walking:
		$Sprite.flip_h = g_facing_right
	else:
		$Sprite.flip_h = !g_facing_right
	
	# animations
	# bad code incoming
	if on_floor:
		if abs(g_dash_velocity.x) > 80:
			if $Sprite/AnimationPlayer.current_animation != "dash":
				$Sprite/AnimationPlayer.play("dash")
		elif abs(g_velocity.x) > 10:
			if $Sprite/AnimationPlayer.current_animation != "walk":
				$Sprite/AnimationPlayer.play("walk")
		else:
			if $Sprite/AnimationPlayer.current_animation != "idle":
				$Sprite/AnimationPlayer.play("idle")
	else:
		if g_velocity.y < 0:
			if $Sprite/AnimationPlayer.current_animation != "jump":
				$Sprite/AnimationPlayer.play("jump")
			elif $Sprite/AnimationPlayer.current_animation != "fall":
				$Sprite/AnimationPlayer.play("fall")
	
	if abs(g_dash_velocity.x) > 80:
			if $Sprite/AnimationPlayer.current_animation != "dash":
				$Sprite/AnimationPlayer.play("dash")
	
	
	# special
	## moonwlaking
	if moon_walk:
		g_is_moon_walking = !g_is_moon_walking
	
	g_combo_timer += delta
	if g_combo_timer > C_COMBO_TIMEOUT:                  
			g_key_combo = []
	
	## dash
	g_dash_timer = min(g_dash_timer + delta, C_DASH_CD)
	
	if g_key_combo.size() == 2 and E_HAS_DASH and g_dash_timer >= C_DASH_CD:
		if g_key_combo[0] == g_key_combo[1]:
			if g_key_combo[0] == "Right" or g_key_combo[0] == "D":
				dash(E_DASH_SPEED)
			elif g_key_combo[0] == "Left" or g_key_combo[0] == "A":
				dash(-E_DASH_SPEED)
			g_dash_timer = 0
	
	g_dash_velocity.x = lerp(g_dash_velocity.x, 0, 0.15)
	
	
	
	
	
	# interact
	var interact = Input.is_action_just_pressed("ui_interact")
	
	if interact:
		var bodies = $InteractArea.get_overlapping_areas()
		for body in bodies:
			if body.get_parent().has_method("interact"):
				body.get_parent().interact()
				break
	
	
	
	
	
func dash(speed):
	set_collision_mask_bit(4, 0)
	$ITimer.start()
	
	g_dash_velocity.x += speed
	g_velocity.y -= 100
	

func take_damage(damage):
	g_health -= damage
	if damage < 0:
		die()

func die():
	print("askglasjfa")


func _on_ITimer_timeout():
	set_collision_mask_bit(4, 1)
