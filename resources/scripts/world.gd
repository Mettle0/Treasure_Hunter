extends Node3D


@export var StageList: Array[PackedScene]

func _ready() -> void:
	EventBus.switch_level.connect(_on_switch_level)
	print(StageList)
	
	
	
func _on_switch_level(currentLevel, nextLevel) -> void:
	var nextScene = nextLevel.instantiate()
	var currentScene = get_child(get_children().bsearch(currentLevel))
	remove_child(currentScene)
	add_child(nextScene)
	
	
