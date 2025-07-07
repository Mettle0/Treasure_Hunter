extends State

@export var idleState: State
@export var fallingState: State
@export var glidingState: State
@export var grabbingLedgeState: State

@export var air_movement_factor: float

var movement_input: Vector2


func state_physics(delta) -> State:
	if parent.is_on_floor() or (parent.is_on_wall_only() and Input.is_action_just_pressed("jump")):
		parent.velocity.y = -parent.jump_velocity
	var gravity = parent.jump_gravity if parent.velocity.y > 0.0 else parent.fall_gravity
	parent.velocity.y -= gravity * delta
	
	#if parent.near_grabbableLedge and parent.can_ledgeGrab:
		#return grabbingLedgeState
	horizontal_movement_air()
	
	if parent.velocity.y < 0.0:
		return fallingState
	
	if Input.is_action_just_pressed("jump") and not parent.is_on_wall_only():
		return glidingState
		
	if parent.velocity.y <= 0.0 and parent.is_on_floor():
		return idleState
	else:
		return null


func horizontal_movement_air() -> void:
	var movement_input = movement.get_direction()
	var vel_2d = Vector2(parent.velocity.x, parent.velocity.z)
	
	if movement_input:
		vel_2d = movement_input * parent.base_speed
		parent.velocity.x = vel_2d.x*air_movement_factor
		parent.velocity.z = vel_2d.y*air_movement_factor
		parent.pivot.look_at(parent.global_position+Vector3(parent.velocity.x,0, parent.velocity.z), Vector3.UP)
	else:
		vel_2d = vel_2d.lerp(Vector2.ZERO,0.1)
		#vel_2d = vel_2d.move_toward(Vector2.ZERO, parent.base_speed*0.05)
		parent.velocity.x = vel_2d.x
		parent.velocity.z = vel_2d.y
