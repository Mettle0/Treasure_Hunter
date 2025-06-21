class_name StateMachine
extends Node

@onready var current_state: int = states.IDLE

enum states{
	IDLE,
	WALKING,
	RUNNING,
	JUMPING,
	GLIDING
	}


func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	
	match current_state:
		states.IDLE:
			print("Idle")
