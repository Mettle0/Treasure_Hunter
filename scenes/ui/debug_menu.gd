extends CanvasLayer


@onready var radar_values: Label = $"Radar Values"
@onready var player_state: Label = $"Player State"


func _ready() -> void:
	EventBus.update_debug_info.connect(_get_debug_info)
	EventBus.playerStateChange.connect(_update_playerState_debug)
	
	

func _update_playerState_debug(currentState: StringName) -> void:
	player_state.text = "Player State: " + str(currentState)

func _get_debug_info(debugInfo) -> void:
	var debug_info_radar
	var debug_info_direction
	var debug_info_text: String = "Item Distances:"
	debug_info_radar = debugInfo["Radar Distance"]
	
	for dist in range(len(debug_info_radar)):
		debug_info_text += "\n" + "Item " + str(dist+1) + ": " + str(round(debug_info_radar[dist]))
	
	
	radar_values.text = debug_info_text
