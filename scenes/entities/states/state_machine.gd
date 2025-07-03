extends Node
class_name StateMachine


@export var init_state: State
@onready var current_state: State

signal stateChange(currenStateName: StringName)


func setup(parent: Player, movement: Movement) -> void:
	for child:ParentState in get_children():
		child.parent = parent
		child.movement = movement
		child.setup_substates(parent, movement)
		
	switch_state(init_state)

func switch_state(new_state: State) -> void:
	if current_state:
		current_state.exit_state()
	current_state = new_state
	current_state.enter_state()
	stateChange.emit(current_state.name)

func state_input(event: InputEvent) -> void:
	var state = current_state.state_input(event)
	if state:
		switch_state(state)

func state_physics(delta: float) -> void:
	var state = current_state.state_physics(delta)
	if state:
		switch_state(state)
	
func state_process(delta: float) -> void:
	var state = current_state.state_process(delta)
	if state:
		switch_state(state)
