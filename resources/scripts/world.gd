extends Node3D


@export var StageList: Array[PackedScene]
@export var StartingScene: PackedScene

func _ready() -> void:
	EventBus.switch_level.connect(_on_switch_level)
	#EventBus.ledge_detected.connect(_on_ledge_detected)
	add_child(StartingScene.instantiate())
	
	
	
func _on_switch_level(currentLevel, nextLevel) -> void:
	var nextScene = nextLevel.instantiate()
	var currentScene = get_child(get_children().bsearch(currentLevel))
	currentScene.call_deferred("queue_free")
	add_child(nextScene)
	
func _on_ledge_detected(ledge_position):
	var ledgeDebugSphere = SphereMesh.new()
	ledgeDebugSphere.radius = 0.25
	ledgeDebugSphere.radial_segments = 4
	ledgeDebugSphere.height = 0.5
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(0, 0, 1)
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	ledgeDebugSphere.surface_set_material(0, material)
	
	var ledgePoint = MeshInstance3D.new()
	ledgePoint.mesh = ledgeDebugSphere
	add_child(ledgePoint)
	ledgePoint.global_position = ledge_position
