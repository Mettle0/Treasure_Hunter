extends Node3D

@export var min_limit_x: float
@export var max_limit_x: float
@export var horizontal_acceleration := 3.0
@export var vertical_acceleration := 2.0
@export var mouse_acceleration := 0.005

func _ready() -> void:
	#Window grabs the cursor on startup
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	var joy_dir = Input.get_vector("pan_left","pan_right","pan_up","pan_down")
	rotate_from_vector(joy_dir * delta * Vector2(horizontal_acceleration, vertical_acceleration))

func _input(event: InputEvent) -> void:
	cursorCap(event)
	
	#Use mouse motion to rotate camera
	if event is InputEventMouseMotion:
		rotate_from_vector(event.relative * mouse_acceleration)

func rotate_from_vector(v: Vector2):
	if v.length() == 0: return
	rotation.y -= v.x
	rotation.x -= v.y
	rotation.x = clamp(rotation.x, min_limit_x, max_limit_x)

func cursorCap(event: InputEvent) -> void:
	#Function that handles capturing and releasing the mouse cursor from the game window
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_pressed("left click"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
