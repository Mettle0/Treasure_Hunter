extends State



@export var idleState: State
@export var wallJump: State
@export var wall_slide_factor: float = 1.0

@onready var wall_slide_cooldown: Timer = %"Wall Slide Cooldown"


func enter_state() -> void:
	var turning_angle: float = (parent.pivot.global_basis.z.angle_to((parent.wallNormal)))
	if parent.pivot.global_basis.z.cross(parent.wallNormal).y < 0:
		parent.pivot.look_at(parent.position + parent.wallNormal.rotated(Vector3.UP, -turning_angle))
	else:
		parent.pivot.look_at(parent.position + parent.wallNormal.rotated(Vector3.UP, turning_angle))
	parent.velocity = Vector3.ZERO
	
func exit_state() -> void:
	wall_slide_cooldown.start()

func state_physics(delta) -> State:
	parent.velocity.y -= parent.fall_gravity*wall_slide_factor * delta
	if Input.is_action_just_pressed("jump"):
		return wallJump
	
	if parent.is_on_floor():
		return idleState
	else:
		return null
