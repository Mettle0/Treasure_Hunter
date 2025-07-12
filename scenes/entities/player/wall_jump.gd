extends State

@export var fallingState: State
@export var horizontal_air_speed: float
@export var wall_jump_height: float = 10.0

func enter_state() -> void:
	parent.velocity.y = wall_jump_height
	parent.velocity.x = parent.pivot.global_basis.z.x*-horizontal_air_speed
	parent.velocity.z = parent.pivot.global_basis.z.z*-horizontal_air_speed



func state_physics(delta) -> State:
	var gravity = parent.jump_gravity if parent.velocity.y > 0.0 else parent.fall_gravity
	parent.velocity.y -= gravity * delta
	if parent.velocity.y < 0.0:
		return fallingState
	return null
