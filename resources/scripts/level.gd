extends Node3D

@export var item_count_target: int = 3
@onready var item_count: int = 0


func _ready() -> void:
	EventBus.treasure_collected.connect(_on_treasure_collected)
	EventBus.stage_buttonPressed.connect(_on_stage_buttonPressed)
	
	
	
func _on_treasure_collected() -> void:
	item_count += 1
	print(item_count)
	if item_count >= item_count_target:
		print("Level Complete")
		EventBus.level_complete.emit()
		
func _on_stage_buttonPressed(buttonID) -> void:
	print("Button " + str(buttonID.name) + " was pressed")
