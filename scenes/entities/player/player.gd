extends CharacterBody3D

#Jump, movement, and glide variables
@export var jump_height : float = 2.25
@export var jump_time_to_peak : float = 0.4
@export var jump_time_to_descent : float = 0.3
@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
@export var base_speed :float = 10
@export var glide_speed : float = -1.5 # Adjust glide descent speed
@onready var camera = $CameraController/Camera3D


var movement_input := Vector2.ZERO
var is_gliding := false

func _physics_process(delta: float) -> void:
	
	#velocity = Vector3(movement_input.x,0,movement_input.y) * base_speed
	move_logic(delta)
	jump_logic(delta)
	move_and_slide()
	
func move_logic(delta) -> void:
	movement_input = Input.get_vector("left","right","forward","backward").rotated(-camera.global_rotation.y)
	var vel_2d = Vector2(velocity.x, velocity.z)
	
	if movement_input:
		vel_2d = movement_input * base_speed
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y
	else:
		vel_2d = vel_2d.move_toward(Vector2.ZERO, base_speed)
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y

func jump_logic(delta) -> void:
	if is_on_floor():
		is_gliding = false # Resets glide state when landing
		if Input.is_action_just_pressed("jump"):
			velocity.y = -jump_velocity

	elif Input.is_action_just_pressed("jump"): #Glide by pressing jump while in the air
		is_gliding = true

	if is_gliding:
		if Input.is_action_pressed("jump"): #Hold jump maintains glide status
			velocity.y = glide_speed # Overrides established fall speed with glide speed
		else:
			is_gliding = false
	if not is_gliding:
		var gravity = jump_gravity if velocity.y > 0.0 else fall_gravity
		velocity.y -= gravity * delta
