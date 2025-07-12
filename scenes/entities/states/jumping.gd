extends State

@export var idleState: State
@export var fallingState: State
@export var glidingState: State
@export var grabbingLedgeState: State
@export var wallSlideState: State

@onready var wall_slide_cooldown: Timer = %"Wall Slide Cooldown"
@export var air_movement_factor: float

var movement_input: Vector2

func enter_state() -> void:
	#if parent.is_on_wall_only():
		#parent.velocity.x = -parent.jump_velocity*parent.wallNormal.x
		#parent.velocity.z = -parent.jump_velocity*parent.wallNormal.z
	parent.velocity.y = -parent.jump_velocity


func state_physics(delta) -> State:
	var gravity = parent.jump_gravity if parent.velocity.y > 0.0 else parent.fall_gravity
	parent.velocity.y -= gravity * delta
	
	
	horizontal_movement_air()
	
	if parent.can_wallslide and wall_slide_cooldown.is_stopped():
		return wallSlideState
	
	if parent.velocity.y < 0.0:
		return fallingState

	if Input.is_action_just_pressed("jump") and not parent.is_on_wall():
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
