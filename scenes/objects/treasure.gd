extends Node3D





func _ready() -> void:
	pass
	

func _physics_process(_delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		EventBus.treasure_collected.emit()
		queue_free()
