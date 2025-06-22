class_name State
extends Node


@export var stateAnimation: String
@export var stateName: String

@onready var parent: Player


func enter_state() -> void:
	parent.animations.play(stateAnimation)
	
func exit_state() -> void:
	pass

func process_inputs(input: InputEvent) -> State:
	return null

func process(delta: float) -> State:
	return null
	
func physics_process(delta: float) -> State:
	return null
