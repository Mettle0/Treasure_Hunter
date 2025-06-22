extends Node

@onready var initial_state: String
@onready var current_state: String


@export var states: Array[String]


func _ready() -> void:
	for state in range(len(states)):
		states[state] = states[state].to_upper()

func setup(initState: String) -> void:
	current_state = initState.to_upper()
	print(current_state)
	
func switch_state(state: String) -> void:
	current_state = state.to_upper()
	print(current_state)
