extends State

@export var jumpingState: State
@export var fallingState: State
@export var ledgeGrabCooldownTimer: Timer



func enter_state() -> void:
	parent.velocity = Vector3.ZERO
	parent.position = parent.ledgeGrabPos - Vector3(0, 2.0, 0)
	parent.can_ledgeGrab = false
	parent.near_grabbableLedge = false
	
func exit_state() -> void:
	ledgeGrabCooldownTimer.start(0.5)
	
	
func state_physics(_delta) -> State:
	if Input.is_action_just_pressed("jump"):
		return jumpingState
	else:
		return null
