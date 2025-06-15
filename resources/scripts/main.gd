extends Node

#Get references to all children of main
@onready var ui: Control = $UI
@onready var player: CharacterBody3D = $Player
@onready var world: Node3D = $World
@onready var radar_distance_calc: Timer = $"Global Timers/RadarDistanceCalc"

@onready var current_item_locations: Array
@onready var radarDistance: Array



func _ready() -> void:
	EventBus.item_positions.connect(_item_positions_received)
	
	
	
func _item_positions_received(pos) -> void:
	current_item_locations = pos


func _on_radar_distance_calc_timeout() -> void:
	radarDistance.clear()
	for loc in current_item_locations:
		var distanceVector: Vector3 = loc - player.position
		var distanceMag = distanceVector.length()
		radarDistance.append(distanceMag)
	var radarDebug = {"Radar Distance": radarDistance}
	EventBus.update_debug_info.emit(radarDebug)
