extends Node3D

@onready var chosen_locations: Array
@onready var locations: Array

@export var NumberOfItems: int
const TREASURE = preload("res://scenes/objects/treasure.tscn")


func _ready() -> void:
	#Connect to treasure collection signal
	EventBus.treasure_collected.connect(_on_treasure_collected)
	
	#Get an array of all possible locations, which exist as nodes that are
	#added as children of the location manager
	locations = get_children()
	
	var treasure_set = get_spawns()					#Run get spawns function, and put them in an array.
	for loc in range(len(treasure_set)):			#These are the chosen spawn points for the level.
		var newTreasure = TREASURE.instantiate()	#Loops through the length of the array of chosen
		treasure_set[loc].add_child(newTreasure)	#spawn points, for any arbitrary number of items.
	
	var spawn_locations: Array
	for spawn in treasure_set:
		spawn_locations.append(spawn.position)
	EventBus.item_positions.emit(spawn_locations)
	
	
func get_spawns() -> Array:
	#get_spawns()	First, clears chosen locations array. Then, creates a duplicate of the locations
	#array that can be freely shuffled. Then, uses slice on this shuffled array to make a new array of
	#shuffled spawn points depending on the NumberOfItems variable. Returns an array.
	chosen_locations.clear()
	var choices = locations.duplicate()
	choices.shuffle()
	chosen_locations = choices.slice(0, NumberOfItems)
	return chosen_locations

func spawn_treasure() -> void:
	pass

func _on_treasure_collected() -> void:
	print("Treasure Collected")
