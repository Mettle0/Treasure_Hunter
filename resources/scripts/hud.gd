extends CanvasLayer
const LEVEL_COMPLETE_SCREEN = preload("res://scenes/ui/level_complete_screen.tscn")

func _ready() -> void:
	EventBus.level_complete.connect(_on_level_complete)
	

func _process(_delta: float) -> void:
	pass

func _on_level_complete() -> void:
	var levelComplete = LEVEL_COMPLETE_SCREEN.instantiate()
	add_child(levelComplete)
