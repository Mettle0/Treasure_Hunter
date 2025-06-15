extends Node3D


@export var StageList: Array[PackedScene]
@export var StartingScene: PackedScene

func _ready() -> void:
	EventBus.switch_level.connect(_on_switch_level)
	add_child(StartingScene.instantiate())
	
	
	
func _on_switch_level(currentLevel, nextLevel) -> void:
	var nextScene = nextLevel.instantiate()
	var currentScene = get_child(get_children().bsearch(currentLevel))
	currentScene.call_deferred("queue_free")
	add_child(nextScene)
	
	
