extends Node3D

@onready var chosen_locations: Array
@onready var locations: Array
const TREASURE = preload("res://scenes/objects/treasure.tscn")


func _ready() -> void:
	#Todo: Add comments
	EventBus.treasure_collected.connect(_on_treasure_collected)
	
	locations = get_children()
	var treasure_set: Array
	treasure_set = get_locations()
	for loc in range(len(treasure_set)):
		var newTreasure = TREASURE.instantiate()
		treasure_set[loc].add_child(newTreasure)

func get_locations() -> Array:
	chosen_locations.clear()
	var choices = locations.duplicate()
	choices.shuffle()
	chosen_locations = choices.slice(0, 3)
	return chosen_locations

func spawn_treasure() -> void:
	pass

func _on_treasure_collected() -> void:
	print("Treasure Collected")
