extends CanvasLayer


@onready var radar_values: Label = $"Radar Values"

func _ready() -> void:
	EventBus.update_debug_info.connect(_get_debug_info)
	
	
func _get_debug_info(debugInfo) -> void:
	var debug_info
	var debug_info_text: String = "Item Distances:"
	debug_info = debugInfo["Radar Distance"]
	
	for dist in range(len(debug_info)):
		debug_info_text += "\n" + "Item " + str(dist+1) + ": " + str(round(debug_info[dist]))
	
	radar_values.text = debug_info_text
