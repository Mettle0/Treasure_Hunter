extends State

@export var idleState: State
@export var jumpState: State


var movement_input: Vector2


func state_physics(delta: float) -> State:
	movement_input = Input.get_vector("left", "right", "forward", "backward").rotated(-parent.camera.global_rotation.y)
	var vel_2d = Vector2(parent.velocity.x, parent.velocity.z)
	
	if movement_input:
		vel_2d = movement_input * parent.base_speed
		parent.velocity.x = vel_2d.x
		parent.velocity.z = vel_2d.y
		parent.pivot.look_at(parent.global_position+Vector3(parent.velocity.x,0, parent.velocity.z), Vector3.UP)
	else:
		vel_2d = vel_2d.move_toward(Vector2.ZERO, parent.base_speed)
		parent.velocity.x = vel_2d.x
		parent.velocity.z = vel_2d.y
		
	if Input.is_action_just_pressed("jump"):
		return jumpState
	elif parent.velocity == Vector3.ZERO:
		return idleState
	else:
		return null
