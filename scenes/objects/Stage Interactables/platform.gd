extends AnimatableBody3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var buttonState: bool



# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.stage_buttonPressed.connect(_on_stage_buttonPressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_stage_buttonPressed(buttonID) -> void:
	if buttonState == false:
		buttonState = true
		animation_player.play("Elevator")
		var SoundButton = AudioStreamPlayer.new()
		SoundButton.stream = preload("res://resources/ButtonBeep.mp3")
		add_child(SoundButton)
		SoundButton.play()
	
