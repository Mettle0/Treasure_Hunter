extends Control

@onready var debug_menu: CanvasLayer = $"Debug Menu"

const HUD = preload("res://scenes/ui/hud.tscn")

var showDebug: bool = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Debug"):
		debug_menu.visible = !debug_menu.visible
			
