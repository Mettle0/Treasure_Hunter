extends Node3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.stage_buttonPressed.connect(_on_stage_buttonPressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_stage_buttonPressed(buttonID) -> void:
	animation_player.play("Elevator")
