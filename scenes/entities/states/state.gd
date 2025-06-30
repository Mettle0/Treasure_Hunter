class_name State
extends Node


@export var stateAnimation: String

@onready var parent: Player


func enter_state() -> void:
	pass
	
func exit_state() -> void:
	pass

func state_input(event: InputEvent) -> State:
	return null

func state_physics(delta: float) -> State:
	return null
	
func state_process(delta: float) -> State:
	return null
	
