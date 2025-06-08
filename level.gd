extends Node3D

@export var item_count_target: int = 3
@onready var item_count: int = 0


func _ready() -> void:
	EventBus.treasure_collected.connect(_on_treasure_collected)
	
	
	
func _on_treasure_collected() -> void:
	item_count += 1
	print(item_count)
	if item_count >= item_count_target:
		print("Level Complete")
		EventBus.level_complete.emit()
