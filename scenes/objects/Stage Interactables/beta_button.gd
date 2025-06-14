extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var buttonPressed: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_switch_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") && not buttonPressed:
		buttonPressed = true
		animation_player.play("Pressed")
		EventBus.stage_buttonPressed.emit(self)
