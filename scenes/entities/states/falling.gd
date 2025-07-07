extends State

@export var idleState: State
@export var glideState: State
@export var moveState: State
@export var grabbingLedgeState: State
@export var air_movement_factor: float

var movement_input: Vector2

func state_physics(delta) -> State:
	if parent.near_grabbableLedge and parent.can_ledgeGrab:
		return grabbingLedgeState
	
	if Input.is_action_just_pressed("jump"):
		return glideState
	horizontal_movement_air()
	
	parent.velocity.y -= parent.fall_gravity * delta
	if parent.is_on_floor():
		if parent.velocity == Vector3.ZERO:
			return idleState
		else:
			return moveState
	return null


func horizontal_movement_air() -> void:
	print(parent.velocity)
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
