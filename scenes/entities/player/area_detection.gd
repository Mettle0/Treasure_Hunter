class_name AreaDetection3D
extends  Node3D


@onready var player: Player = $"../.."

#Ledge finding nodes
@onready var ledge_finder_ray: RayCast3D = %"Ledge Finder Ray"
@onready var wall_detection_ray: RayCast3D = %"Wall Detection Ray"

#Wall sliding notes
@onready var upper_ray_cast: RayCast3D = $"Wall Slide Detection/Upper RayCast"
@onready var lower_ray_cast: RayCast3D = $"Wall Slide Detection/Lower RayCast"

signal facingLedge(ledgePos: Vector3)
signal facingWall(wall_collision_normal: Vector3)

func _physics_process(delta: float) -> void:
	ledge_detection()
	wallslide_detection()
	
	
	
	
func ledge_detection() -> void:
	if wall_detection_ray.is_colliding():
		player.facingWall = true
		ledge_finder_ray.enabled = true
		player.wallNormal = wall_detection_ray.get_collision_normal()
		if ledge_finder_ray.is_colliding():
			facingLedge.emit(ledge_finder_ray.get_collision_point())
			player.can_ledgeGrab = true
		else:
			player.wallNormal = Vector3.ZERO
			player.can_ledgeGrab = false
	else: #Tell the player they're not facing a wall, and not near a grabbable ledge.
		player.facingWall = false
		player.near_grabbableLedge = false
		ledge_finder_ray.enabled = false
		player.ledgeGrabPos = Vector3.ZERO
		


func wallslide_detection() -> void:
	if player.is_on_wall_only() and upper_ray_cast.is_colliding() and lower_ray_cast.is_colliding():
		player.wallNormal = upper_ray_cast.get_collision_normal()
		player.can_wallslide = true
	else:
		player.can_wallslide = false
