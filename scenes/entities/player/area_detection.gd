extends  Node3D

#@onready var wall_detection_ray: RayCast3D = $"Wall Detection Ray"
#@onready var ledge_detector: Node3D = $"Ledge Detector"
#@onready var ledge_detection_ray: RayCast3D = $"Ledge Detector/Ledge Detection Ray"
@onready var ledge_debug_sphere: MeshInstance3D = $"Ledge Debug Sphere"
@onready var player: Player = $"../.."

signal facingLedge(ledgePos: Vector3)
signal notFacingLedge

@onready var ledge_top_finder: RayCast3D = $"Ledge Top Finder"
@onready var ledge_detection_ray_lower: RayCast3D = $"Ledge Detection Ray Lower"



func _physics_process(delta: float) -> void:
	if ledge_detection_ray_lower.is_colliding():# and player.can_ledgeGrab:
		ledge_detection()
	else:
		notFacingLedge.emit()



func ledge_detection() -> void:
	var wallDist: Vector3 = ledge_detection_ray_lower.get_collision_point()
	var offset: Vector3 = Vector3(0, 0.25, 0)
	var space_state = get_world_3d().direct_space_state
		
	var query = PhysicsRayQueryParameters3D.create(wallDist+offset, wallDist,2)
	var hit: Dictionary = space_state.intersect_ray(query)
	if ledge_top_finder.is_colliding():
		facingLedge.emit(ledge_top_finder.get_collision_point())
		ledge_debug_sphere.global_position = ledge_top_finder.get_collision_point()
		#ledge_debug_sphere.visible = true
	else:
		ledge_debug_sphere.visible = false
			
	

	#if wall_detection_ray.is_colliding():
		#ledge_detection()
		#
	#else:
		#ledge_detection_ray.enabled = false
		#ledge_debug_sphere.visible = false
	#
#
#func ledge_detection() -> void:
	#ledge_detection_ray.enabled = true
	#var wall_detected_location = wall_detection_ray.get_collision_point()
	#ledge_detector.global_position = wall_detected_location + Vector3(0, 1.0, 0)
#
	#if ledge_detection_ray.is_colliding():
		#var ledge_location: Vector3 = ledge_detection_ray.get_collision_point()
		#ledge_debug_sphere.global_position = ledge_location
		#ledge_debug_sphere.visible = true
		#EventBus.ledge_detected.emit(ledge_location)
	#else:
			#ledge_debug_sphere.visible = false
	

	
