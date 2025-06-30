extends State

@export var jumpState: State
@export var moveState: State

func enter_state():
	super()
	parent.velocity = Vector3.ZERO
	
func state_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		return jumpState
	if Input.get_vector("left", "right", "forward", "backward"):
		return moveState
	else:
		return null
