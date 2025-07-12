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
@onready var area_detection: AreaDetection3D = $"Pivot/Area Detection"
@onready var ledge_grab_cooldown: Timer = $"Cooldowns/Ledge Grab Cooldown"
@onready var movement: Movement = $Movement
@onready var camera_controller: CameraController = $CameraController
@onready var capsule_model: MeshInstance3D = $Pivot/CapsuleModel


#Situational awareness checks for the player. What can the player do in this current moment?
#Can be altered by cooldowns and state changes
var ledgeGrabPos: Vector3
var wallNormal: Vector3 = Vector3.ZERO
var can_ledgeGrab: bool = true
var near_grabbableLedge: bool = false
var facingWall: bool = false
var can_wallslide: bool = false

func _ready() -> void:
	state_machine.setup(self, movement)

func _input(event: InputEvent) -> void:
	state_machine.state_input(event)

func _physics_process(delta: float) -> void:
	#if can_wallslide:
		#print(pivot.basis.z.cross(wallNormal))
	state_machine.state_physics(delta)
	move_and_slide()

#===INCOMING SIGNALS===#
func _on_ledge_grab_cooldown_timeout() -> void:
	can_ledgeGrab = true


func _on_state_machine_state_change(currenStateName: StringName) -> void:
	EventBus.playerStateChange.emit(currenStateName)


func _on_area_detection_facing_ledge(ledgePos: Vector3) -> void:
	ledgeGrabPos = ledgePos
	near_grabbableLedge = true
