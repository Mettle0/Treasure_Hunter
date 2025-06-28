extends  Node3D

@onready var wall_detection_ray: RayCast3D = $"Wall Detection Ray"
@onready var ledge_detector: Node3D = $"Ledge Detector"
@onready var ledge_detection_ray: RayCast3D = $"Ledge Detector/Ledge Detection Ray"
@onready var ledge_debug_sphere: MeshInstance3D = $"Ledge Detector/Ledge Detection Ray/Ledge Debug Sphere"

func _physics_process(delta: float) -> void:
	if wall_detection_ray.is_colliding():
		ledge_detection()
		
	else:
		ledge_detection_ray.enabled = false
		ledge_debug_sphere.visible = false
	

func ledge_detection() -> void:
	ledge_detection_ray.enabled = true
	var wall_detected_location = wall_detection_ray.get_collision_point()
	ledge_detector.global_position = wall_detected_location + Vector3(0, 1.0, 0)

	if ledge_detection_ray.is_colliding():
		var ledge_location: Vector3 = ledge_detection_ray.get_collision_point()
		ledge_debug_sphere.global_position = ledge_location
		ledge_debug_sphere.visible = true
		EventBus.ledge_detected.emit(ledge_location)
	else:
			ledge_debug_sphere.visible = false
	

	
