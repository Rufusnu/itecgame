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

# consts go here

const C_NORMAL = Vector2(0, -1)

const C_COMBO_TIMEOUT = 0.2
const C_MAX_COMBO_CHAIN = 2

const C_DASH_CD = 2
const C_MAX_JUMPS = 2



# globals go here
var g_velocity = Vector2()
var g_dash_velocity = Vector2()

var g_facing_right = true

var g_key_combo = []
var g_combo_timer = 0

var g_dash_timer = 2
var g_jump_number = 0

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
	
	
	if move_right:
		g_velocity.x = min(g_velocity.x + E_ACCEL, E_MAX_WALK_SPEED)
		# anim stuff
	
	if move_left:
		g_velocity.x = max(g_velocity.x - E_ACCEL, -E_MAX_WALK_SPEED)
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
		
	print(g_velocity.y)
	# too much gravity
	if on_floor:
		g_velocity.y = min(g_velocity.y + E_ACCEL, 15)
	else:
		g_velocity.y = min(g_velocity.y + E_GRAVITY, E_MAX_FALL_SPEED)
	
	if !move_right and !move_left:
		if on_floor:
			g_velocity.x = lerp(g_velocity.x, 0, 0.2)
		else:
			g_velocity.x = lerp(g_velocity.x, 0, 0.03)
	# probably more anim stuff
	
	move_and_slide(g_velocity + g_dash_velocity, C_NORMAL)
	# end of movement
	
	# special
	g_combo_timer += delta
	if g_combo_timer > C_COMBO_TIMEOUT:                  
			g_key_combo = []
	
	## dash
	g_dash_timer = min(g_dash_timer + delta, C_DASH_CD)
	
	if g_key_combo.size() == 2 and E_HAS_DASH and g_dash_timer >= C_DASH_CD:
		if g_key_combo[0] == g_key_combo[1]:
			if g_key_combo[0] == "Right" or g_key_combo[0] == "D":
				dash(E_DASH_SPEED, true)
			elif g_key_combo[0] == "Left" or g_key_combo[0] == "A":
				dash(-E_DASH_SPEED, false)
	g_dash_velocity.x = lerp(g_dash_velocity.x, 0, 0.15)
	
	
	
func dash(speed, dir_right):
	g_dash_velocity.x += speed
	