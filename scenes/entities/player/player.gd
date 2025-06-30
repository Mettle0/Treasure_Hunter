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
@onready var movement_input: Vector2


#Get references to other nodes
@onready var camera: Camera3D = $CameraController/Camera3D
@onready var state_machine: StateMachine = $"State Machine"
@onready var pivot: Node3D = $Pivot
@onready var area_detection: Node3D = $"Pivot/Area Detection"
@onready var ledge_grab_cooldown: Timer = $"Cooldowns/Ledge Grab Cooldown"



var ledgeGrabPos: Vector3


#Situational awareness checks for the player. What can the player do in this current moment?
#Can be latered by cooldowns and state changes
var can_ledgeGrab: bool = true


func _ready() -> void:
	state_machine.setup(self)
	#EventBus.ledge_detected.connect(_on_ledge_detected)


func _input(event: InputEvent) -> void:
	state_machine.state_input(event)

func _physics_process(delta: float) -> void:
	state_machine.state_physics(delta)
	
	move_and_slide()


#func _on_ledge_detected(ledgePosition) -> void:
	#if can_ledgeGrab and not is_on_floor():
		#ledgeGrabPos = ledgePosition
		#state_machine.switch_state("Grabbing Ledge")
		#can_ledgeGrab = false


func handle_horizontal_movement() -> void:
	pass


#func check_if_landed() -> void:
	#if is_on_floor():
		#if velocity == Vector3.ZERO:
			#state_machine.switch_state("Idle")
		#else:
			#state_machine.switch_state("Walking")


func get_movement_input() -> Vector2:
	movement_input = Input.get_vector("left","right","forward","backward").rotated(-camera.global_rotation.y)
	return movement_input


#======STATES======#
#func jump_state(delta) -> void:
	#if is_on_floor():
		#velocity.y = -jump_velocity
	#var gravity = jump_gravity if velocity.y > 0.0 else fall_gravity
	#velocity.y -= gravity * delta
	#
	#handle_horizontal_movement()
	#
	#if velocity.y < 0.0:
		#state_machine.switch_state("Falling")
	#
	#if Input.is_action_just_pressed("jump"):
		#state_machine.switch_state("Gliding")
		#
	#if velocity.y <= 0.0 and is_on_floor():
		#state_machine.switch_state("Idle")
#
#
#func fall_state(delta) -> void:
	#check_if_landed()
	#handle_horizontal_movement()
	#if Input.is_action_just_pressed("jump"):
		#state_machine.switch_state("Gliding")
		#
	#var gravity = jump_gravity if velocity.y > 0.0 else fall_gravity
	#velocity.y -= gravity * delta
#
#
#func glide_state(delta) -> void:
	#check_if_landed()
	#handle_horizontal_movement()
	#if Input.is_action_just_released("jump"):
		#state_machine.switch_state("Falling")
	#velocity.y = glide_speed
#
#
#func walking_state(delta) -> void:
	#if not is_on_floor():
		#state_machine.switch_state("Jumping")
		#
	#if Input.is_action_just_pressed("jump"):
		#state_machine.switch_state("Jumping")
		#
	#handle_horizontal_movement()
	#
	#if velocity == Vector3.ZERO:
		#state_machine.switch_state("Idle")
#
#
#func ledge_grab_state(ledgePos: Vector3) -> void:
	#global_position = ledgePos - Vector3(0, 2.0, 0)
	#velocity = Vector3.ZERO
	#if Input.is_action_just_pressed("jump"):
		#global_position += Vector3(1.0, 2.0, 0.0)
		#state_machine.switch_state("Idle")
		#ledge_grab_cooldown.start()
#
#
#func idle_state() -> void:
	#can_ledgeGrab = true
	#velocity = Vector3.ZERO
	#if not is_on_floor():
		#state_machine.switch_state("Jumping")
		#
	#if Input.is_action_just_pressed("jump"):
		#state_machine.switch_state("Jumping")
		#
	#if movement_input:
		#state_machine.switch_state("Walking")


#===INCOMING SIGNALS===#
func _on_ledge_grab_cooldown_timeout() -> void:
	can_ledgeGrab = true
