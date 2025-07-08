extends  Node3D

#@onready var wall_detection_ray: RayCast3D = $"Wall Detection Ray"
#@onready var ledge_detector: Node3D = $"Ledge Detector"
#@onready var ledge_detection_ray: RayCast3D = $"Ledge Detector/Ledge Detection Ray"
@onready var ledge_debug_sphere: MeshInstance3D = $"Ledge Debug Sphere"
@onready var player: Player = $"../.."

signal facingLedge(ledgePos: Vector3)
signal facingWall(wall_collision_normal: Vector3)

@onready var ledge_finder_ray: RayCast3D = $"Ledge Finder Ray"
@onready var wall_detection_ray: RayCast3D = $"Wall Detection Ray"



func _physics_process(delta: float) -> void:
	if wall_detection_ray.is_colliding():# and player.can_ledgeGrab:
		ledge_detection()
		facingWall.emit(wall_detection_ray.get_collision_normal())
	else:
		player.near_grabbableLedge = false
		player.ledgeGrabPos = Vector3.ZERO



func ledge_detection() -> void:
	if ledge_finder_ray.is_colliding():
		facingLedge.emit(ledge_finder_ray.get_collision_point())
		ledge_debug_sphere.global_position = ledge_finder_ray.get_collision_point()
	else:
		ledge_debug_sphere.visible = false

	

	
