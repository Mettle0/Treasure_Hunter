extends Node3D

@onready var locations: Array


func _ready() -> void:
	locations = get_children()
