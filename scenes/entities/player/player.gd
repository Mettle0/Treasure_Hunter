class_name Player
extends CharacterBody3D

#Jump, movement, and glide variables
@onready var currentState: String
@export var jump_height : float = 2.25
@export var jump_time_to_peak : float = 0.4
@export var jump_time_to_descent : float = 0.3
@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
@export var base_speed :float = 10
@export var glide_speed : float = -1.5 # Adjust glide descent speed

#Get references to other nodes
@onready var camera = $CameraController/Camera3D
@onready var state_machine = $"State Machine"
@onready var animations: AnimatedSprite3D = $Animations


var movement_input := Vector2.ZERO
var requestJump: bool
var is_gliding := false

func _ready() -> void:
	
	var states:Array = state_machine.states
	currentState = state_machine.current_state
	state_machine.setup("Idle")

func _physics_process(delta: float) -> void:
	
	handle_inputs()
	
	match currentState:
		"IDLE":
			idle_state()
			
		"WALKING":
			walking_state(delta)
			
		"JUMPING":
			jump_state(delta)
		
		"FALLING":
			fall_state(delta)
		
		"GLIDING":
			glide_state(delta)
			
	move_and_slide()
	currentState = state_machine.current_state
	
func handle_horizontal_movement() -> void:
	var vel_2d = Vector2(velocity.x, velocity.z)
	
	if movement_input:
		vel_2d = movement_input * base_speed
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y
	else:
		vel_2d = vel_2d.move_toward(Vector2.ZERO, base_speed)
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y
	
func walking_state(delta) -> void:
	if not is_on_floor():
		state_machine.switch_state("Jumping")
		
	if Input.is_action_just_pressed("jump"):
		requestJump = true
		state_machine.switch_state("Jumping")
		
	handle_horizontal_movement()
	
	if velocity == Vector3.ZERO:
		state_machine.switch_state("Idle")

#region Airborne Logic
func jump_state(delta) -> void:
	if is_on_floor() and requestJump:
		velocity.y = -jump_velocity
		requestJump = false
	var gravity = jump_gravity if velocity.y > 0.0 else fall_gravity
	velocity.y -= gravity * delta
	
	handle_horizontal_movement()
	
	if velocity.y < 0.0:
		state_machine.switch_state("Falling")
	
	if Input.is_action_just_pressed("jump"):
		state_machine.switch_state("Gliding")
		
	if velocity.y <= 0.0 and is_on_floor():
		state_machine.switch_state("Idle")

func fall_state(delta) -> void:
	check_if_landed()
	handle_horizontal_movement()
	if Input.is_action_just_pressed("jump"):
		state_machine.switch_state("Gliding")
		
	var gravity = jump_gravity if velocity.y > 0.0 else fall_gravity
	velocity.y -= gravity * delta

func glide_state(delta) -> void:
	check_if_landed()
	handle_horizontal_movement()
	if Input.is_action_just_released("jump"):
		state_machine.switch_state("Falling")
	velocity.y = glide_speed
#endregion


func handle_inputs() -> void:
	movement_input = Input.get_vector("left","right","forward","backward").rotated(-camera.global_rotation.y)

func idle_state() -> void:
	velocity = Vector3.ZERO
	if not is_on_floor():
		state_machine.switch_state("Jumping")
		
	if Input.is_action_just_pressed("jump"):
		requestJump = true
		state_machine.switch_state("Jumping")
		
	if movement_input:
		state_machine.switch_state("Walking")

func check_if_landed() -> void:
	if is_on_floor():
		if velocity == Vector3.ZERO:
			state_machine.switch_state("Idle")
		else:
			state_machine.switch_state("Walking")
