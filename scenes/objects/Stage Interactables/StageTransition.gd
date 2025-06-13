extends Area3D

@onready var currentLevel

@export var Destination: PackedScene


func _ready() -> void:
	currentLevel = get_parent().name



func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		EventBus.switch_level.emit(currentLevel, Destination)
