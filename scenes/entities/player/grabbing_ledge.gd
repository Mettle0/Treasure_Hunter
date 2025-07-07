extends State

@export var jumpingState: State
@export var fallingState: State
@export var ledgeGrabCooldownTimer: Timer



func enter_state() -> void:
	parent.velocity = Vector3.ZERO
	parent.global_position = parent.ledgeGrabPos - Vector3(0, 1.5, 0) + parent.ledgeGrabNormal*0.5
	parent.can_ledgeGrab = false
	parent.near_grabbableLedge = false
	
func exit_state() -> void:
	ledgeGrabCooldownTimer.start(0.5)
	
	
func state_physics(_delta) -> State:
	if Input.is_action_just_pressed("jump"):
		return jumpingState
	else:
		return null
