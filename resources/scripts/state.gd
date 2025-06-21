class_name State
extends Node


@export var stateAnimation: String

@onready var parent: Player


func enter_state() -> void:
	parent.animations.play(stateAnimation)
	
func exit_state() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	pass

func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	pass
