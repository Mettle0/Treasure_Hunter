class_name ParentState
extends Node

@onready var parent: Player
@onready var movement: Movement

func setup_substates(parent: Player, movement: Movement) -> void:
	if not get_children().is_empty():
		for child: State in get_children():
			child.parent = parent
			child.movement = movement


func enter_state() -> void:
	pass
	
func exit_state() -> void:
	pass

func state_input(_event: InputEvent) -> State:
	return null

func state_physics(_delta: float) -> State:
	return null
	
func state_process(_delta: float) -> State:
	return null
	
