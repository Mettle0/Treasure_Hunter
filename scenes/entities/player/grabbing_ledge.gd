extends State

@export var jumpingState: State
@export var fallingState: State
@export var ledgeGrabCooldownTimer: Timer
@onready var wall_slide_cooldown: Timer = %"Wall Slide Cooldown"



func enter_state() -> void:
	parent.velocity = Vector3.ZERO
	parent.global_position = parent.ledgeGrabPos - Vector3(0.0, 1.0, 0.0) + parent.wallNormal*0.5
	parent.can_ledgeGrab = false
	parent.near_grabbableLedge = false
	print(parent.wallNormal)
	
func exit_state() -> void:
	wall_slide_cooldown.start()
	ledgeGrabCooldownTimer.start(0.5)
	
	
func state_physics(_delta) -> State:
	if Input.is_action_just_pressed("jump"):
		return jumpingState
	else:
		return null
