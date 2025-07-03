extends Movement

@export var camController: CameraController



func get_direction() -> Vector2:
	return Input.get_vector("left", "right", "forward", "backward").rotated(-camController.global_rotation.y)
	
