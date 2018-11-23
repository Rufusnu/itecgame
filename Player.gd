extends KinematicBody2D


# exports go here
export (int) var E_MAX_WALK_SPEED
export (int) var E_ACCEL

export (int) var E_MAX_FALL_SPEED
export (int) var E_JUMP_SPEED
export (int) var E_GRAVITY

# consts go here

const C_NORMAL = Vector2(0, -1)
const C_COMBO_TIMEOUT = 0.2
const C_MAX_COMBO_CHAIN = 2



# globals go here
var g_velocity = Vector2()
var g_facing_right = true

var g_key_combo = []
var g_combo_timer = 0

func _input(event):
	if event is InputEventKey and event.pressed and !event.echo: 
		if g_combo_timer > C_COMBO_TIMEOUT:                  
			g_key_combo = []
		
		g_key_combo.append(event.scancode)                     
		if g_key_combo.size() > C_MAX_COMBO_CHAIN:               
			g_key_combo.pop_front()
		
		print(g_key_combo)                                     
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
	
	if move_jump and on_floor:
		g_velocity.y -= E_JUMP_SPEED
		# anim stuff
		
	
	# too much gravity
	if on_floor:
		g_velocity.y = min(g_velocity.y + E_ACCEL, 15)
	else:
		g_velocity.y = min(g_velocity.y + E_GRAVITY, E_MAX_FALL_SPEED)
	
	if !move_right and !move_left:
		if on_floor:
			g_velocity.x = lerp(g_velocity.x, 0, 0.2)
		else:
			g_velocity.x = lerp(g_velocity.x, 0, 0.01)
	# probably more anim stuff
	
	move_and_slide(g_velocity, C_NORMAL)
	# end of movement
	
	# special
	## dash
	
	
	
func dash(speed, dir_right):
	pass
	